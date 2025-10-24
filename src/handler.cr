require "./types"

module Hamilton::Handler
  property next : Handler | HandlerProc | Nil

  abstract def call(update : Hamilton::Types::Update)

  def call_next(update : Hamilton::Types::Update) : Nil
    if next_handler = @next
      next_handler.call(update)
    end
  end

  alias HandlerProc = Hamilton::Types::Update ->
end