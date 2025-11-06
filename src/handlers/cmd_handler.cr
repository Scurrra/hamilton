require "../handler"
require "../context"
require "../api"
require "log"
require "string_scanner"

# Available payload types that can be handled by the `Hamilton::CmdHandler`.
PAYLOAD_TYPES = [:animation, :audio, :document, :paid_media, :photo, :sticker, :story, :video, :video_note, :voice, :checklist, :contact, :contact, :dice, :game, :poll, :venue, :location, :invoice, :successful_payment, :refunded_payment, :users_shared, :chat_shared, :passport_data]

# The module for handling commands, callback queries (please, do not use them), known text messages, and some of messages payloads.
#
# Should be included in the class with the implementations of updates' handling functions.
class Hamilton::CmdHandler
  include Hamilton::Handler

  # Mapping between methods and mapper between update types and methods to handle them.
  property mapper : Hash(Symbol, Hash(String | Symbol, Symbol))

  # Context for the current bot sessions.
  property context : Hamilton::Context

  # Logger instance.
  property log : Log

  {% if flag?(:async) %}  
  
  property caller : Hash(Symbol, Proc(Hamilton::Types::Update, Hash(Symbol, JSON::Any) | Nil, Channel(Signal), NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil)))
  property channels : Hash(Int64 | String | Symbol, Channel(Signal))  
  
  def initialize(log_level : Log::Severity = Log::Severity::Info)
    @log = Log.for("Hamilton::Bot Command Handler", log_level)

    @context = Hamilton::Context.new default_method: :root
    @mapper = {:root => Hash(String | Symbol, Symbol).new}
    @caller = Hash(Symbol, Proc(Hamilton::Types::Update, Hash(Symbol, JSON::Any) | Nil, Channel(Signal), NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))).new
    @channels = Hash(Int64 | String | Symbol, Channel(Signal)).new
  end

  def call(update : Hamilton::Types::Update)
    update_types = update.non_nil_fields
    update_types.delete("update_id")
    if update_types.size == 0
      @log.error { "Empty update" }
    elsif update_types[0] == "message" || update_types[0] == "business_message"
      # message itself
      message = update.message.as(Hamilton::Types::Message | Nil)
      message ||= update.business_message.as(Hamilton::Types::Message | Nil)
      message = message.as(Hamilton::Types::Message)

      # as we have message we definitely have non-nil context
      # for empty context it will be created when calling `get_method` with `{method: :root, data: nil}` value
      ctxt_method = @context.get_method(message.chat.id)

      # possible messages mapper for the last method from the chat's context
      # should not be nil
      pmm = @mapper[ctxt_method]
      @log.debug { "Possible messages mapping :: [#{pmm}]" }

      # non-nil fields
      message_fields = message.non_nil_fields

      {% begin %}
      case message_fields
      
      # first check for command or known text payload from `ReplyKeyboard`
      when .includes?("text")
        ss = StringScanner.new(message.text.as(String))

        # trim spaces at start
        ss.scan(/\s*/)

        # check if the message is of type `signal`
        if ss.check("/signal")
          ss.scan(/\/\w+\s+/)
          signal = Signal.parse ss.rest

          if @channels.has_key?(message.chat.id)
            @channels[message.chat.id].send signal
          else
            @log.info { "Update #{update.update_id} is of type `signal` and has no effect as no running fibers found" }
          end

          return call_next(update)
        end


        # check for existance of a channel
        if @channels.has_key?(message.chat.id)
          @channels[message.chat.id].send Signal::TSTP
          @log.warn { "Update #{update.update_id} tried to run while there is an another process. #{Signal::TSTP} was sent to the current process" }
          return call_next(update)
        end

        # check if we a command here
        if ss.check('/')
          # retrive the command
          cmd = ss.scan(/\/\w+/)

          @log.debug { "Comand :: [#{cmd}] :: [#{pmm[cmd]?}]" }

          if method = pmm[cmd]?

            @channels[message.chat.id] = Channel(Signal).new

            new_context = @caller[method].call(update, @context.get_data(message.chat.id), @channels[message.chat.id])
            if @mapper[method].size != 0
              @context.set(
                message.chat.id,
                new_context
              )
            else
              @context.clean(message.chat.id)
              @context.set(message.chat.id, new_context[:data])
            end  
            
            @channels[message.chat.id].close
            @channels.delete(message.chat.id)

          else
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:command` [#{cmd}] payload that can not be processed" }
          end

          # just text
        else
          known_texts = pmm.keys.select! { |key| key.is_a?(String) &&!key.as(String).starts_with?('/') }
          @log.debug { "Known texts :: [#{known_texts}]" }
          text_index = 0
          while text_index < known_texts.size
            if ss.check(known_texts[text_index].as(String))
              # get the method
              method = pmm[ss.scan(known_texts[text_index].as(String))]
              # trim spaces at start of the remaining text
              ss.scan(/\s+/)

              @channels[message.chat.id] = Channel(Signal).new

              new_context = @caller[method].call(update, @context.get_data(message.chat.id), @channels[message.chat.id])
              if @mapper[method].size != 0
                @context.set(
                  message.chat.id,
                  new_context
                )
              else
                @context.clean(message.chat.id)
                @context.set(message.chat.id, new_context[:data])
              end  
              
              @channels[message.chat.id].close
              @channels.delete(message.chat.id)

              break
            else
              text_index += 1
            end
          end

          if text_index == known_texts.size
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:text` payload that can not be processed (and I don't know why)" }
          end
        end

      # ... and then for other available message payload types
      {% for payload_type in PAYLOAD_TYPES %}
      when .includes?({{payload_type}}.to_s)
        if method = pmm[{{payload_type}}]?

          @channels[message.chat.id] = Channel(Signal).new

          new_context = @caller[method].call(update, @context.get_data(message.chat.id), @channels[message.chat.id])
          if @mapper[method].size != 0
            @context.set(
              message.chat.id,
              new_context
            )
          else
            @context.clean(message.chat.id)
            @context.set(message.chat.id, new_context[:data])
          end            
          
          @channels[message.chat.id].close
          @channels.delete(message.chat.id)
        
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `{{payload_type}}` payload that can not be processed" }
        end
      {% end %}
      
      else
        @log.info { "Update #{update.update_id} is of type `message`/`business_message` and contains payload that can not be processed by Command Handler" }
      end
      {% end %}
    elsif update_types[0] == "callback_query"
      @log.warn { "Hamilton's developer doesn't recommend to use `InlineKeybord`s" }

      callback_query = update.callback_query.as(Hamilton::Types::CallbackQuery)
      update_data = callback_query.data
      update_data ||= callback_query.game_short_name
      if data = update_data
        # there are three options how to identify chat or user who sent this

        # 1. `chat_instance` --- "Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent."
        # This is the only type where `chat_instance` is used, but it always presents here.
        if chat_instance = callback_query.chat_instance
          # one more erason to not use this shit: "Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data."
          # as `chat_instance` is never null, the `get_method?` method is used to not get `:root`
          # P.S. I didn't understand what `chat_instance` is so here is some workaround to not fuck up
          if ctxt_method = @context.get_method?(chat_instance)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?

                @channels[chat_instance] = Channel(Signal).new

                new_context = @caller[method].call(update, @context.get_data(chat_instance), @channels[chat_instance])
                if @mapper[method].size != 0
                  @context.set(
                    chat_instance,
                    new_context
                    )
                else
                  @context.clean(chat_instance)
                  @context.set(chat_instance, new_context[:data])
                end
                
                @channels[chat_instance].close
                @channels.delete(chat_instance)

                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `chat_instance`" }
              end
            end
          end
        end

        # 2. usual and most normal option: detect chat the original message (that one with `inline_keyboard`) was sent
        # `callback_query` may have `message` field from which we may try to extract the chat's id
        if original_message = callback_query.message
          # message is of type `Hamilton::Types::MaybeInaccessibleMessage` and anyways contains chat info
          # let's assume that `callback_query` can not be sent in the chat with empty context
          # i.e. to `:root`
          if ctxt_method = @context.get_method?(original_message.chat.id)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?
                
                @channels[original_message.chat.id] = Channel(Signal).new

                new_context = @caller[method].call(update, @context.get_data(original_message.chat.id), @channels[original_message.chat.id])
                if @mapper[method].size != 0
                  @context.set(
                    original_message.chat.id,
                    new_context
                  )
                else
                  @context.clean(original_message.chat.id)
                  @context.set(original_message.chat.id, new_context[:data])
                end
                
                @channels[original_message.chat.id].close
                @channels.delete(original_message.chat.id)
                
                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `message.chat.id`" }
              end
            end
          end
        end

        # 3. for some reason let's check sender's id
        # `callback_query` contains `from` field from which sender's id may be obtained
        if user_id = callback_query.from.id
          # if the only way to handle `callback_query` is with user id, there is probably no known context
          # in this case ctxt_method = ctxt[:method] will be ":root" and data will be empty
          # `get_method?` is called to not create new context in case of error
          ctxt_method = @context.get_method?(user_id) || :root
          if @mapper.has_key?(ctxt_method)
            if method = @mapper[ctxt_method][data]?
              
              @channels[user_id] = Channel(Signal).new

              new_context = @caller[method].call(update, @context.get_data(user_id), @channels[user_id])
              if @mapper[method].size != 0
                @context.set(
                  user_id,
                  new_context
                )
              else
                @context.clean(user_id)
                @context.set(user_id, new_context[:data])
              end
              
              @channels[user_id].close
              @channels.delete(user_id)
              
              return call_next(update)
            else
              @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `from.id` (sender's/user id)" }
            end
          end
        end
      else
        @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't contain any payload. If the update won't be procesed user may hang (see the note for `Hamilton::Types::CallbackQuery`)" }
      end
    else
      @log.info { "Update #{update.update_id} was skipped by `CmdHandler` due to unknown update type" }
    end

    call_next(update)
  end

  {% else %}

  property caller : Hash(Symbol, Proc(Hamilton::Types::Update, Hash(Symbol, JSON::Any) | Nil, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil)))

  def initialize(log_level : Log::Severity = Log::Severity::Info)
    @log = Log.for("Hamilton::Bot Command Handler", log_level)

    @context = Hamilton::Context.new default_method: :root
    @mapper = {:root => Hash(String | Symbol, Symbol).new}
    @caller = Hash(Symbol, Proc(Hamilton::Types::Update, Hash(Symbol, JSON::Any) | Nil, NamedTuple(method: Symbol | Nil, data: Hash(Symbol, JSON::Any) | Nil))).new
  end
  
  def call(update : Hamilton::Types::Update)
    update_types = update.non_nil_fields
    update_types.delete("update_id")
    if update_types.size == 0
      @log.error { "Empty update" }
    elsif update_types[0] == "message" || update_types[0] == "business_message"
      # message itself
      message = update.message
      message ||= update.business_message
      message = message.as(Hamilton::Types::Message)

      # as we have message we definitely have non-nil context
      # for empty context it will be created when calling `get_method` with `{method: :root, data: nil}` value
      ctxt_method = @context.get_method(message.chat.id)

      # possible messages mapper for the last method from the chat's context
      # should not be nil
      pmm = @mapper[ctxt_method]
      @log.debug { "Possible messages mapping :: [#{pmm}]" }

      # non-nil fields
      message_fields = message.non_nil_fields

      {% begin %}
      case message_fields
      
      # first check for command or known text payload from `ReplyKeyboard`
      when .includes?("text")
        ss = StringScanner.new(message.text.as(String))

        # trim spaces at start
        ss.scan(/\s*/)

        # check if we a command here
        if ss.check('/')
          # retrive the command
          cmd = ss.scan(/\/\w+/)

          @log.debug { "Comand :: [#{cmd}] :: [#{pmm[cmd]?}]" }

          if method = pmm[cmd]?
            new_context = @caller[method].call(update, @context.get_data(message.chat.id))
            if @mapper[method].size != 0
              @context.set(
                message.chat.id,
                new_context
              )
            else
              @context.clean(message.chat.id)
              @context.set(message.chat.id, new_context[:data])
            end
          else
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:command` [#{cmd}] payload that can not be processed" }
          end

          # just text
        else
          known_texts = pmm.keys.select! { |key| key.is_a?(String) &&!key.as(String).starts_with?('/') }
          @log.debug { "Known texts :: [#{known_texts}]" }
          text_index = 0
          while text_index < known_texts.size
            if ss.check(known_texts[text_index].as(String))
              # get the method
              method = pmm[ss.scan(known_texts[text_index].as(String))]
              # trim spaces at start of the remaining text
              ss.scan(/\s+/)

              new_context = @caller[method].call(update, @context.get_data(message.chat.id))
              if @mapper[method].size != 0
                @context.set(
                  message.chat.id,
                  new_context
                )
              else
                @context.clean(message.chat.id)
                @context.set(message.chat.id, new_context[:data])
              end
              break
            else
              text_index += 1
            end
          end

          if text_index == known_texts.size
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:text` payload that can not be processed (and I don't know why)" }
          end
        end

      # ... and then for other available message payload types
      {% for payload_type in PAYLOAD_TYPES %}
      when .includes?({{payload_type}}.to_s)
        if method = pmm[{{payload_type}}]?
          new_context = @caller[method].call(update, @context.get_data(message.chat.id))
          if @mapper[method].size != 0
            @context.set(
              message.chat.id,
              new_context
            )
          else
            @context.clean(message.chat.id)
            @context.set(message.chat.id, new_context[:data])
          end
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `{{payload_type}}` payload that can not be processed" }
        end
      {% end %}
      
      else
        @log.info { "Update #{update.update_id} is of type `message`/`business_message` and contains payload that can not be processed by Command Handler" }
      end
      {% end %}
    elsif update_types[0] == "callback_query"
      @log.warn { "Hamilton's developer doesn't recommend to use `InlineKeybord`s" }

      callback_query = update.callback_query.as(Hamilton::Types::CallbackQuery)
      update_data = callback_query.data
      update_data ||= callback_query.game_short_name
      if data = update_data
        # there are three options how to identify chat or user who sent this

        # 1. `chat_instance` --- "Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent."
        # This is the only type where `chat_instance` is used, but it always presents here.
        if chat_instance = callback_query.chat_instance
          # one more erason to not use this shit: "Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data."
          # as `chat_instance` is never null, the `get_method?` method is used to not get `:root`
          # P.S. I didn't understand what `chat_instance` is so here is some workaround to not fuck up
          if ctxt_method = @context.get_method?(chat_instance)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?
                new_context = @caller[method].call(update, @context.get_data(chat_instance))
                if @mapper[method].size != 0
                  @context.set(
                    chat_instance,
                    new_context
                  )
                else
                  @context.clean(chat_instance)
                  @context.set(chat_instance, new_context[:data])
                end
                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `chat_instance`" }
              end
            end
          end
        end

        # 2. usual and most normal option: detect chat the original message (that one with `inline_keyboard`) was sent
        # `callback_query` may have `message` field from which we may try to extract the chat's id
        if original_message = callback_query.message
          # message is of type `Hamilton::Types::MaybeInaccessibleMessage` and anyways contains chat info
          # let's assume that `callback_query` can not be sent in the chat with empty context
          # i.e. to `:root`
          if ctxt_method = @context.get_method?(original_message.chat.id)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?
                new_context = @caller[method].call(update, @context.get_data(original_message.chat.id))
                if @mapper[method].size != 0
                  @context.set(
                    original_message.chat.id,
                    new_context
                  )
                else
                  @context.clean(original_message.chat.id)
                  @context.set(original_message.chat.id, new_context[:data])
                end
                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `message.chat.id`" }
              end
            end
          end
        end

        # 3. for some reason let's check sender's id
        # `callback_query` contains `from` field from which sender's id may be obtained
        if user_id = callback_query.from.id
          # if the only way to handle `callback_query` is with user id, there is probably no known context
          # in this case ctxt_method = ctxt[:method] will be ":root" and data will be empty
          # `get_method?` is called to not create new context in case of error
          ctxt_method = @context.get_method?(user_id) || :root
          if @mapper.has_key?(ctxt_method)
            if method = @mapper[ctxt_method][data]?
              new_context = @caller[method].call(update, @context.get_data(user_id))
              if @mapper[method].size != 0
                @context.set(
                  user_id,
                  new_context
                )
              else
                @context.clean(user_id)
                @context.set(user_id, new_context[:data])
              end
              return call_next(update)
            else
              @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `from.id` (sender's/user id)" }
            end
          end
        end
      else
        @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't contain any payload. If the update won't be procesed user may hang (see the note for `Hamilton::Types::CallbackQuery`)" }
      end
    else
      @log.info { "Update #{update.update_id} was skipped by `CmdHandler` due to unknown update type" }
    end

    call_next(update)
  end
  
  {% end %}
end

# Annotation for the method in implementation of `Hamilton::CmdHandler`.
#
# In `#[Handler]` an instance of `Hamilton::CmdHandler` should be provided.
annotation Handler
end

# Annotation for the method in implementation of `Hamilton::CmdHandler`.
#
# In `#[Handle]` there should be one of the following parameters:
#  - `command` for handling a bot command
#  - `text` for handling a known text massage
#  - `callback` for handling a `callback_query` with provided content
#  -  unnamed parameter that is one of the symbols from `Hamilton::CmdHandler::PAYLOAD_TYPES`
annotation Handle
end

# Annotation for the method in implementation of `Hamilton::CmdHandler`.
#
# In `#[For]` a list of symbolic names of the methods that are predecessors of the update to be handled.
# If no names provided the initial update is handled.
annotation For
end

# :nodoc:
macro method_added(method)
  {% if flag?(:async) %}

  {% if method.annotation(Handler) %}
    {% unless method.annotation(Handler)[0] %}
      raise Hamilton::Errors::MissingCmdHandlerMethodAnnotationArg.new "Handler"
    {% end %}

    %handler = {{ method.annotation(Handler)[0] }}
  
    {% if method.annotation(Handle) %}
      
      {% unless method.args.map(&.name.symbolize).includes?(:context) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :context
      {% end %}

      
      {% unless method.args.map(&.name.symbolize).includes?(:update) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :update
      {% end %}


      {% unless method.args.map(&.name.symbolize).includes?(:signal) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :signal
      {% end %}
      
      # commands
      {% if method.annotation(Handle).named_args.has_key?(:command) %}

      {% if method.annotation(Handle)[:command].starts_with?('/') && method.annotation(Handle)[:command] == "/signal" %}
        raise UnsupportedCmdHandlerCommand.new
      {% end %}

      {% if !method.annotation(Handle)[:command].starts_with?('/') && method.annotation(Handle)[:command] == "signal" %}
        raise UnsupportedCmdHandlerCommand.new
      {% end %}

      %value = {{method.annotation(Handle)[:command]}}
      %value = if %value.starts_with?('/')
        %value
      else
        "/" + %value
      end
      {% unless method.args.map(&.name.symbolize).includes?(:argument) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :argument
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil, signal : Channel(Signal)){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        ss = StringScanner.new(message.text.as(String))
        ss.scan(/\s*\/\w+\s+/)
        
        result = {{method.name.id}}(argument: ss.rest, update: update, context: context, signal: signal)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # callbacks
      {% elsif method.annotation(Handle).named_args.has_key?(:callback) %}
      %value = {{method.annotation(Handle)[:callback]}}
      {% unless method.args.map(&.name.symbolize).includes?(:callback) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :callback
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | NiNil, signal : Channel(Signal)){
        result = {{method.name.id}}(update: update, context: context, signal: signal)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # known text 
      {% elsif method.annotation(Handle).named_args.has_key?(:text) %}
      %value = {{method.annotation(Handle)[:text]}}
      {% unless method.args.map(&.name.symbolize).includes?(:remaining_text) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :remaining_text
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil, signal : Channel(Signal)){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        ss = StringScanner.new(message.text.as(String))
        ss.scan(/\s*/)
        ss.scan(%value)
        ss.scan(/\s+/)
        
        result = {{method.name.id}}(remaining_text: ss.rest, update: update, context: context, signal: signal)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # other types
      {% elsif method.annotation(Handle).args.size != 0 %}
      %value = {{method.annotation(Handle)[0]}}

      {% unless PAYLOAD_TYPES.includes?(method.annotation(Handle)[0]) %}
        raise Hamilton::Errors::UnsupportedCmdHandlerPayloadType.new %value
      {% end %}

      {% unless method.args.map(&.name.symbolize).includes?(method.annotation(Handle)[0]) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new %value
      {% end %}

      {% for arg in method.args %}
        {% if arg.name.symbolize == method.annotation(Handle)[0] %}        

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil, signal : Channel(Signal)){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        
        {% if arg.restriction %}
        result = {{method.name.id}}({{arg.name.id}}: message.{{arg.name.id}}.as({{arg.restriction}}), update: update, context: context, signal: signal)
        {% else %}
        result = {{method.name.id}}({{arg.name.id}}: message.{{arg.name.id}}, update: update, context: context, signal: signal)
        {% end %}
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

        {% end %}
      {% end %}

      # no args
      {% else %}
        raise Hamilton::Errors::MissingCmdHandlerMethodAnnotationArg.new "Handle"
      {% end %}

      {% if method.annotation(For) %}
        {% for method_ in method.annotation(For).args %}
        %handler.mapper[{{method_.id.symbolize}}][%value] = {{method.name.symbolize}}
        {% end %}
      {% else %}
        %handler.mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      {% unless method.annotation(For) %}
        %handler.mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      %handler.mapper[{{method.name.symbolize}}] = Hash(String | Symbol, Symbol).new
    {% end %}
  {% end %}

  {% else %}

  {% if method.annotation(Handler) %}
    {% unless method.annotation(Handler)[0] %}
      raise Hamilton::Errors::MissingCmdHandlerMethodAnnotationArg.new "Handler"
    {% end %}

    %handler = {{ method.annotation(Handler)[0] }}
  
    {% if method.annotation(Handle) %}
      
      {% unless method.args.map(&.name.symbolize).includes?(:context) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :context
      {% end %}

      
      {% unless method.args.map(&.name.symbolize).includes?(:update) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :update
      {% end %}
      
      
      # commands
      {% if method.annotation(Handle).named_args.has_key?(:command) %}
      
      %value = {{method.annotation(Handle)[:command]}}
      %value = if %value.starts_with?('/')
        %value
      else
        "/" + %value
      end
      {% unless method.args.map(&.name.symbolize).includes?(:argument) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :argument
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        ss = StringScanner.new(message.text.as(String))
        ss.scan(/\s*\/\w+\s+/)
        
        result = {{method.name.id}}(argument: ss.rest, update: update, context: context)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # callbacks
      {% elsif method.annotation(Handle).named_args.has_key?(:callback) %}
      %value = {{method.annotation(Handle)[:callback]}}
      {% unless method.args.map(&.name.symbolize).includes?(:callback) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :callback
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil){
        result = {{method.name.id}}(update: update, context: context)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # known text 
      {% elsif method.annotation(Handle).named_args.has_key?(:text) %}
      %value = {{method.annotation(Handle)[:text]}}
      {% unless method.args.map(&.name.symbolize).includes?(:remaining_text) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new :remaining_text
      {% end %}

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        ss = StringScanner.new(message.text.as(String))
        ss.scan(/\s*/)
        ss.scan(%value)
        ss.scan(/\s+/)
        
        result = {{method.name.id}}(remaining_text: ss.rest, update: update, context: context)
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

      # other types
      {% elsif method.annotation(Handle).args.size != 0 %}
      %value = {{method.annotation(Handle)[0]}}

      {% unless PAYLOAD_TYPES.includes?(method.annotation(Handle)[0]) %}
        raise Hamilton::Errors::UnsupportedCmdHandlerPayloadType.new %value
      {% end %}

      {% unless method.args.map(&.name.symbolize).includes?(method.annotation(Handle)[0]) %}
        raise Hamilton::Errors::MissingCmdHandlerMethodParam.new %value
      {% end %}

      {% for arg in method.args %}
        {% if arg.name.symbolize == method.annotation(Handle)[0] %}        

      %handler.caller[{{method.name.symbolize}}] = ->(update : Hamilton::Types::Update, context : Hash(Symbol, JSON::Any) | Nil){
        message = update.message
        message ||= update.business_message
        message = message.as(Hamilton::Types::Message)
        
        {% if arg.restriction %}
        result = {{method.name.id}}({{arg.name.id}}: message.{{arg.name.id}}.as({{arg.restriction}}), update: update, context: context)
        {% else %}
        result = {{method.name.id}}({{arg.name.id}}: message.{{arg.name.id}}, update: update, context: context)
        {% end %}
        if result
          context = result          
        end
        {method: {{method.name.symbolize}}.as(Symbol | Nil), data: context.as(Hash(Symbol, JSON::Any) | Nil)}
      }

        {% end %}
      {% end %}

      # no args
      {% else %}
        raise Hamilton::Errors::MissingCmdHandlerMethodAnnotationArg.new "Handle"
      {% end %}

      {% if method.annotation(For) %}
        {% for method_ in method.annotation(For).args %}
        %handler.mapper[{{method_.id.symbolize}}][%value] = {{method.name.symbolize}}
        {% end %}
      {% else %}
        %handler.mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      {% unless method.annotation(For) %}
        %handler.mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      %handler.mapper[{{method.name.symbolize}}] = Hash(String | Symbol, Symbol).new
    {% end %}
  {% end %}
  
  {% end %}
end
