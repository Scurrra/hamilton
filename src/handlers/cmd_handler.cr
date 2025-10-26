require "../handler"
require "../context"
require "../api"
require "log"
require "string_scanner"

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

# The module for handling commands, callback queries (please, do not use them), known text messages, and some of messages payloads.
#
# Should be included in the class with the implementations of updates' handling functions.
module Hamilton::CmdHandler
  include Hamilton::Handler

  # Available payload types that can be handled by the `Hamilton::CmdHandler`.
  PAYLOAD_TYPES = [:animation, :audio, :document, :paid_media, :photo, :sticker, :story, :video, :video_note, :voice, :checklist, :contact, :contact, :dice, :game, :poll, :venue, :location, :invoice, :successful_payment, :refunded_payment, :users_shared, :chat_shared, :passport_data]
  
  # Mapping between methods and mapper between update types and methods to handle them.
  property mapper : Hash(Symbol, Hash(String | Symbol, Symbol))

  # Context for the current bot sessions.
  property context : Hamilton::Context
  
  # Logger instance.
  property log : Log

  # API instance to be used inside the handler.
  property api : Hamilton::Api

  def initialize(@api)
    @log = Log.for("Hamilton::Bot Command Handler")
    @context = Hamilton::Context.new default_method: :root
    @mapper = {:root => Hash(String | Symbol, Symbol).new}
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

      # as we have message we definitely have non-nil context 
      # for empty context it will be created when calling `get_method` with `{method: :root, data: nil}` value
      ctxt_method = @context.get_method(message.chat.id)

      # possible messages mapper for the last method from the chat's context
      # should not be nil
      pmm = @mapper[ctxt_method]
      
      # non-nil fields
      message_fields = message.non_nil_fields

      # first check for command or known text payload from `ReplyKeyboard`
      case message_fields
      when .includes?("text")
        ss = StringScanner.new(message.text)
        
        # trim spaces at start
        ss.scan(/\s+/)

        # check if we a command here
        if ss.check('/')
          # retrive the command
          cmd = ss.scan(/\/\w+/)
          # trim spaces at start of the argument text
          ss.scan(/\s+/)

          if method = pmm[cmd]?
            {{method.id}}.call(argument: ss.rest, context_key: message.chat.id, update: update)
          else
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:command` [#{cmd}] payload that can not be processed" }
          end
        
        # just text
        else
          known_texts = pmm.keys.select! {|key| typeof(key) === String && !key.starts_with?('/')}
          text_index = 0
          while text_index < known_texts.size
            if ss.check(known_texts[text_index])
              # get the method
              method = pmm[ss.scan(known_texts[text_index])]
              # trim spaces at start of the remaining text
              ss.scan(/\s+/)
              
              {{method.id}}.call(remaining_text: ss.rest, context_key: message.chat.id, update: update)
              break
            else
              text_index += 1
            end            
          end

          if text_index == known_texts.size
            @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:text` payload that can not be processed (and I don't know why)" }
          end
        end
      
      #TODO: replace following with macro generator
      when .includes?("animation")
        if method = pmm[:animation]?
          {{method.id}}.call(animation: message.animation, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:animation` payload that can not be processed" }
        end
      when .includes?("audio")
        if method = pmm[:audio]?
          {{method.id}}.call(audio: message.audio, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:audio` payload that can not be processed" }
        end
      when .includes?("document")
        if method = pmm[:document]?
          {{method.id}}.call(document: message.document, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:document` payload that can not be processed" }
        end
      when .includes?("paid_media")
        if method = pmm[:paid_media]?
          {{method.id}}.call(paid_media: message.paid_media, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:paid_media` payload that can not be processed" }
        end
      when .includes?("photo")
        if method = pmm[:photo]?
          {{method.id}}.call(photo: message.photo, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:photo` payload that can not be processed" }
        end
      when .includes?("sticker")
        if method = pmm[:sticker]?
          {{method.id}}.call(sticker: message.sticker, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:sticker` payload that can not be processed" }
        end
      when .includes?("story")
        if method = pmm[:story]?
          {{method.id}}.call(story: message.story, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:story` payload that can not be processed" }
        end
      when .includes?("video")
        if method = pmm[:video]?
          {{method.id}}.call(video: message.video, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:video` payload that can not be processed" }
        end
      when .includes?("video_note")
        if method = pmm[:video_note]?
          {{method.id}}.call(video_note: message.video_note, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:video_note` payload that can not be processed" }
        end
      when .includes?("voice")
        if method = pmm[:voice]?
          {{method.id}}.call(voice: message.voice, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:voice` payload that can not be processed" }
        end
      when .includes?("checklist")
        if method = pmm[:checklist]?
          {{method.id}}.call(checklist: message.checklist, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:checklist` payload that can not be processed" }
        end
      when .includes?("contact")
        if method = pmm[:contact]?
          {{method.id}}.call(contact: message.contact, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:contact` payload that can not be processed" }
        end
      when .includes?("dice")
        if method = pmm[:dice]?
          {{method.id}}.call(dice: message.dice, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:dice` payload that can not be processed" }
        end
      when .includes?("game")
        if method = pmm[:game]?
          {{method.id}}.call(game: message.game, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:game` payload that can not be processed" }
        end
      when .includes?("poll")
        if method = pmm[:poll]?
          {{method.id}}.call(poll: message.poll, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:poll` payload that can not be processed" }
        end
      when .includes?("venue")
        if method = pmm[:venue]?
          {{method.id}}.call(venue: message.venue, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:venue` payload that can not be processed" }
        end
      when .includes?("location")
        if method = pmm[:location]?
          {{method.id}}.call(location: message.location, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:location` payload that can not be processed" }
        end
      when .includes?("invoice")
        if method = pmm[:invoice]?
          {{method.id}}.call(invoice: message.invoice, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:invoice` payload that can not be processed" }
        end
      when .includes?("successful_payment")
        if method = pmm[:successful_payment]?
          {{method.id}}.call(successful_payment: message.successful_payment, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:successful_payment` payload that can not be processed" }
        end
      when .includes?("refunded_payment")
        if method = pmm[:refunded_payment]?
          {{method.id}}.call(refunded_payment: message.refunded_payment, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:refunded_payment` payload that can not be processed" }
        end
      when .includes?("users_shared")
        if method = pmm[:users_shared]?
          {{method.id}}.call(users_shared: message.users_shared, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:users_shared` payload that can not be processed" }
        end
      when .includes?("chat_shared")
        if method = pmm[:chat_shared]?
          {{method.id}}.call(chat_shared: message.chat_shared, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:chat_shared` payload that can not be processed" }
        end
      when .includes?("passport_data")
        if method = pmm[:passport_data]?
          {{method.id}}.call(passport_data: message.passport_data, context_key: message.chat.id, update: update)
        else
          @log.warn { "Update #{update.update_id} is of type `message`/`business_message` and contains `:passport_data` payload that can not be processed" }
        end
      else
        @log.info { "Update #{update.update_id} is of type `message`/`business_message` and contains payload that can not be processed by Command Handler" }
      end

    elsif update_types[0] == "callback_query"
      @log.warn { "Hamilton's developer doesn't recommend to use `InlineKeybord`s" }
      
      update_data = update.callback_query.data
      update_data ||= update.callback_query.game_short_name
      if data = update_data 
        # there are three options how to identify chat or user who sent this
        
        # 1. `chat_instance` --- "Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent."
        # This is the only type where `chat_instance` is used, but it always presents here.
        if chat_instance = update.callback_query.chat_instance
          # one more erason to not use this shit: "Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data." 
          # as `chat_instance` is never null, the `get_method?` method is used to not get `:root` 
          # P.S. I didn't understand what `chat_instance` is so here is some workaround to not fuck up
          if ctxt_method = @context.get_method?(chat_instance)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?
                {{method.id}}.call(callback: data, context_key: chat_instance, update: update)
                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `chat_instance`" }
              end
            end
          end
        end
        
        # 2. usual and most normal option: detect chat the original message (that one with `inline_keyboard`) was sent
        # `callback_query` may have `message` field from which we may try to extract the chat's id
        if message = update.callback_query.message
          # message is of type `Hamilton::Types::MaybeInaccessibleMessage` and anyways contains chat info
          chat_id = message.chat.id
          # let's assume that `callback_query` can not be sent in the chat with empty context
          # i.e. to `:root`
          if ctxt_method = @context.get_method?(chat_id)
            if @mapper.has_key?(ctxt_method)
              if method = @mapper[ctxt_method][data]?
                {{method.id}}.call(callback: data, context_key: chat_id, update: update)
                return call_next(update)
              else
                @log.warn { "Update #{update.update_id} is of type `callback_query` and doesn't have a handler for the provided payload when handled with `message.chat.id`" }
              end
            end
          end
        end

        # 3. for some reason let's check sender's id
        # `callback_query` contains `from` field from which sender's id may be obtained
        if user_id = update.callback_query.from.id
          # if the only way to handle `callback_query` is with user id, there is probably no known context
          # in this case ctxt_method = ctxt[:method] will be ":root" and data will be empty
          # `get_method?` is called to not create new context in case of error
          ctxt_method = @context.get_method?(user_id) || :root
          if @mapper.has_key?(ctxt_method)
            if method = @mapper[ctxt_method][data]?
              {{method.id}}.call(callback: data, context_key: user_id, update: update)
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

  # :nodoc:
  macro method_added(method)
    {% if method.annotation(Handle) %}
      {% unless method.args.map(&.name.symbolize).includes?(:context_key) %}
        raise MissingCmdHandlerMethodParam.new :context_key
      {% end %}

      {% unless method.args.map(&.name.symbolize).includes?(:update) %}
        raise MissingCmdHandlerMethodParam.new :update
      {% end %}
      
      {% if method.annotation(Handle).named_args.has_key?(:command) %}
      %value = {{method.annotation(Handle)[:command].stringify}}
      %value = if %value.starts_with?('/')
        %value
      else
        "/" + %value
      end
      {% unless method.args.map(&.name.symbolize).includes?(:argument) %}
        raise MissingCmdHandlerMethodParam.new :argument
      {% end %}
      {% elsif method.annotation(Handle).named_args.has_key?(:callback) %}
      %value = {{method.annotation(Handle)[:callback].stringify}}
      {% unless method.args.map(&.name.symbolize).includes?(:callback) %}
        raise MissingCmdHandlerMethodParam.new :callback
      {% end %}
      {% elsif method.annotation(Handle).named_args.has_key?(:text) %}
      %value = {{method.annotation(Handle)[:text].stringify}}
      {% unless method.args.map(&.name.symbolize).includes?(:remaining_text) %}
        raise MissingCmdHandlerMethodParam.new :remaining_text
      {% end %}
      {% elsif method.annotation(Handle).args.size != 0 %}
      %value = {{method.annotation(Handle)[0].symbolize}}

      {% unless PAYLOAD_TYPES.includes?(method.annotation(Handle)[0].symbolize) %}
        raise UnspportedCmdHandlerPayloadType.new %value
      {% end %}

      {% unless method.args.map(&.name.symbolize).includes?(method.annotation(Handle)[0].symbolize) %}
        raise MissingCmdHandlerMethodParam.new %value
      {% end %}
      {% else %}
        raise MissingCmdHandlerMethodAnnotationArg.new "Handle"
      {% end %}

      {% for method_ in method.annotation(For).args %}
      @mapper[{{mapper_.symbolize}}][%value] = {{method.name.symbolize}}
      {% end %}

      {% if method.annotation(For).args.size == 0 %}
        @mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      {% unless method.annotation(For) %}
        @mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      @mapper[{{method.name.symbolize}}] = Hash(String | Symbol, Symbol).new
    {% end %}
  end

end