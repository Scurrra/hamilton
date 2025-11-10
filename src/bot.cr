require "./api"
require "./handler"
require "./types"
require "log"

# `Hamilton::Bot` implementation variant.
class Hamilton::Bot
  # API instance to be used inside the Bot.
  property api : Hamilton::Api

  # Logger instance.
  property log : Log

  # Chain of handlers.
  property handler : Hamilton::Handler | Hamilton::Handler::HandlerProc

  # :nodoc:
  property is_running : Bool

  # Offset of the updates, i.e. the number of the first update to be handled.
  property offset : Int32

  # Timeout in seconds for long polling.
  property timeout : Int32

  # Creates a bot provided `offset`, `timeout`, api instance created from `token` and `url` for `env`, and the given block as handler.
  def self.new(*, offset = 0, timeout = 20, token : String, url : String = "https://api.telegram.org", env : Symbol = :prod, &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: handler)
  end

  # Creates a bot provided `offset`, `timeout`, `api`, and the given block as handler.
  def self.new(*, offset = 0, timeout = 20, api : Hamilton::Api, &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: api, handler: handler)
  end

  # Creates a bot provided `offset`, `timeout`, api instance created from `token` and `url` for `env`, and a handler chain constructed from the `handlers`
  # array and the given block.
  def self.new(*, offset = 0, timeout = 20, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler), &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: Hamilton::Bot.build_middleware(handlers, handler))
  end

  # Creates a bot provided `offset`, `timeout`, `api`, and a handler chain constructed from the `handlers`
  # array and the given block.
  def self.new(*, offset = 0, timeout = 20, api : Hamilton::Api, handlers : Indexable(Hamilton::Handler), &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: api, handler: Hamilton::Bot.build_middleware(handlers, handler))
  end

  # Creates a bot provided `offset`, `timeout`, api instance created from `token` and `url` for `env`, and the `handlers` array as handler chain.
  def self.new(*, offset = 0, timeout = 20, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler)) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: Hamilton::Bot.build_middleware(handlers))
  end

  # Creates a bot provided `offset`, `timeout`, `api`, and the `handlers` array as handler chain.
  def self.new(*, offset = 0, timeout = 20, api : Hamilton::Api, handlers : Indexable(Hamilton::Handler)) : self
    new(offset: offset, timeout: timeout, api: api, handler: Hamilton::Bot.build_middleware(handlers))
  end

  def initialize(*, @offset = 0, @timeout = 20, @api : Hamilton::Api, @handler : Hamilton::Handler | Hamilton::Handler::HandlerProc)
    @is_running = false
    @log = Log.for("Hamilton::Bot")
  end

  # Start listening for the updates with long pooling.
  def listen
    @is_running = true
    @log.info { "Bot started with offset #{@offset}" }

    while @is_running
      begin
        updates = @api.getUpdates(offset: @offset, timeout: @timeout)
        if updates
          updates.each do |update|
            @offset = update.update_id + 1

            begin
            {% if flag?(:async) %}
              # if code is compiled with :async on, handler is spawning on a separate fiber
              # inside `CmdHandler` implicit `/signal` command is created to provide an interface 
              # for passing signals to running handlers on older updates and ignoring incoming ones
              spawn @handler.call(update)
            {% else %}
              # cannot be spawned on a separate fiber as there can possibly occure errors while handling updates of the same user
              @handler.call(update)
            {% end %}  
            rescue api_call_fail : Hamilton::Errors::ApiEndpointError
              @log.error(exception: api_call_fail)
            rescue api_method_error : Hamilton::Errors::MissingParam | Hamilton::Errors::ParamTypeMissmatch
              @log.error(exception: api_method_error) { "Error when calling a `Hamilton::Api` method" }
            rescue exception
              # catch some unknown errors to hide stacktrace for developer's privacy purpose
              @log.error(exception: exception) { "Unknown, probably runtime, exception." }
            end
          end
        end
      
      # these catch only errors in `.getUpdates`
      # as there can be multiple updates and error during processing one cancels all the upcoming ones
      # processing of each update has it's own error catching blocks 
      rescue api_call_fail : Hamilton::Errors::ApiEndpointError
        @log.error(exception: api_call_fail)
      rescue api_method_error : Hamilton::Errors::MissingParam | Hamilton::Errors::ParamTypeMissmatch
        @log.error(exception: api_method_error) { "Error when calling a `Hamilton::Api` method" }
      rescue exception
        # catch some unknown errors to hide stacktrace for developer's privacy purpose
        @log.error(exception: exception) { "Unknown, probably runtime, exception." }
      end
      end
    end
  end

  # Stop listening for the updates.
  #
  # One of the ways to call it is:
  # ```crysal
  # Signal::INT.trap do
  #   puts bot.stop
  # end
  # ```
  def stop
    @is_running = false
    @log.info { "Bot stopped with offset #{@offset}" }
  end

  # :nodoc:
  def self.build_middleware(handlers : Indexable(Hamilton::Handler), last_handler : (Hamilton::Types::Update ->)? = nil) : Hamilton::Handler
    raise ArgumentError.new "You must specify at least one Hamilton Handler." if handlers.empty?
    0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }
    handlers.last.next = last_handler if last_handler
    handlers.first
  end
end
