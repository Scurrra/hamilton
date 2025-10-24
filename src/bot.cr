require "./api"
require "./handler"
require "log"

class Hamilton::Bot

  property api : Hamilton::Api
  property log : Log
  property handler : Hamilton::Handler | Hamilton::Handler::HandlerProc
  property is_running

  def self.new(*, token, url = "https://api.telegram.org", env = :prod, &handler : Hamilton::Handler::HandlerProc) : self
    new(handler)
  end

  def self.new(*, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler), &handler : Hamilton::Handler::HandlerProc) : self
    new(Hamilton::Bot.build_middleware(handlers, handler))
  end

  def self.new(*, token, url = "https://api.telegram.org", env = :prod, handlers : Indexable(Hamilton::Handler)) : self
    new(Hamilton::Bot.build_middleware(handlers))
  end

  private def initialize(*, token : String, url : String, env : Symbol, @handler : Hamilton::Handler | Hamilton::Handler::HandlerProc)
    @api = Hamilton::Api.new(token, url, env)
    @log = Log.for("Hamilton::Bot")
  end

  # TODO: listen

  private def self.build_middleware(handlers : Indexable(Hamilton::Handler), last_handler : (Hamilton::Types::Update ->)? = nil) : Hamilton::Handler
    raise ArgumentError.new "You must specify at least one Hamilton Handler." if handlers.empty?
    0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }
    handlers.last.next = last_handler if last_handler
    handlers.first
  end
end