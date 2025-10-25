require "./api"
require "./handler"
require "./types"
require "log"

class Hamilton::Bot
  property api : Hamilton::Api
  property log : Log
  property handler : Hamilton::Handler | Hamilton::Handler::HandlerProc
  property is_running : Bool
  property offset : Int32
  property timeout : Int32

  def self.new(*, offset, timeout, token : String, url : String = "https://api.telegram.org", env : Symbol = :prod, &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: handler)
  end

  def self.new(*, offset, timeout, api : Hamilton::Api, &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: api, handler: handler)
  end

  def self.new(*, offset, timeout, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler), &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: Hamilton::Bot.build_middleware(handlers, handler))
  end

  def self.new(*, offset, timeout, api : Hamilton::Api, handlers : Indexable(Hamilton::Handler), &handler : Hamilton::Handler::HandlerProc) : self
    new(offset: offset, timeout: timeout, api: api, handler: Hamilton::Bot.build_middleware(handlers, handler))
  end

  def self.new(*, offset, timeout, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler)) : self
    new(offset: offset, timeout: timeout, api: Hamilton::Api.new(token, url, new), handler: Hamilton::Bot.build_middleware(handlers))
  end

  def self.new(*, offset, timeout, api : Hamilton::Api, handlers : Indexable(Hamilton::Handler)) : self
    new(offset: offset, timeout: timeout, api: api, handler: Hamilton::Bot.build_middleware(handlers))
  end

  private def initialize(*, @offset = 0, @timeout = 20, @api : Hamilton::Api, @handler : Hamilton::Handler | Hamilton::Handler::HandlerProc)
    @is_running = false
    @log = Log.for("Hamilton::Bot")
  end

  def listen
    @is_running = true
    @log.info { "Bot started with offset #{@offset}" }

    while @is_running
      begin
        @api.getUpdates(offset = @offset, timeout = @timeout).each do |update|
          @offset = update.update_id + 1
          @handler.call(update)
        end
      rescue api_call_fail : Hamilton::Errors::ApiEndpointError
        @log.error(exception: api_call_fail)
      rescue api_method_error : Hamilton::Errors::MissingParam | Hamilton::Errors::ParamTypeMissmatch
        @log.error(exception: api_method_error) { "Error when calling a `Hamilton::Api` method" }
      end
    end
  end

  def stop
    @is_running = false
    @log.info { "Bot stopped with offset #{@offset}" }
  end

  private def self.build_middleware(handlers : Indexable(Hamilton::Handler), last_handler : (Hamilton::Types::Update ->)? = nil) : Hamilton::Handler
    raise ArgumentError.new "You must specify at least one Hamilton Handler." if handlers.empty?
    0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }
    handlers.last.next = last_handler if last_handler
    handlers.first
  end
end
