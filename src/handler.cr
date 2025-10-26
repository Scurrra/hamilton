require "./types"

# Basic module for updates' handler.
#
# Should be included in custom handler class.
module Hamilton::Handler
  
  # Next handler to be called.
  property next : Handler | HandlerProc | Nil

  # Handling method that processes an update.
  abstract def call(update : Hamilton::Types::Update)

  # Method that calls the next handler.
  def call_next(update : Hamilton::Types::Update) : Nil
    if next_handler = @next
      next_handler.call(update)
    end
  end

  # The last handler may also be a separate function, so this is the type of such a function.
  alias HandlerProc = Hamilton::Types::Update ->
end