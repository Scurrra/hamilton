require "json"
require "./utils.cr"

# This object describes a message that was deleted or is otherwise inaccessible to the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InaccessibleMessage
  include Hamilton::Types::Common

  # Chat the message belonged to.
  property chat : Hamilton::Types::Chat
  
  # Unique message identifier inside the chat.
  property message_id : Int32

  # Always 0. The field can be used to differentiate regular and inaccessible messages.
  property date : Int32
end

# This object describes a message that can be inaccessible to the bot.
alias Hamilton::Types::MaybeInaccessibleMessage = Hamilton::Types::Message | Hamilton::Types::InaccessibleMessage