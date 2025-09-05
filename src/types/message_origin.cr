require "json"
require "./utils.cr"

# The message was originally sent by a known user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageOriginUser
  include Hamilton::Types::Common

  # Type of the message origin, always “user”.
  property type : String

  # Date the message was sent originally in Unix time.
  property date : Int32

  # User that sent the message originally.
  property sender_user : Hamilton::Types::User
end

# The message was originally sent by an unknown user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageOriginHiddenUser
  include Hamilton::Types::Common

  # Type of the message origin, always "hidden_user".
  property type : String

  # Date the message was sent originally in Unix time.
  property date : Int32

  # Name of the user that sent the message originally.
  property sender_user_name	: String
end

# The message was originally sent on behalf of a chat to a group chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageOriginChannel
  include Hamilton::Types::Common

  # Type of the message origin, always "chat".
  property type : String

  # Date the message was sent originally in Unix time.
  property date : Int32

  # Chat that sent the message originally.
  property sender_chat : Hamilton::Types::Chat

  # For messages originally sent by an anonymous chat administrator, original message author signature.
  property author_signature : String | Nil
end

# The message was originally sent to a channel chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageOriginUser
  include Hamilton::Types::Common

  # Type of the message origin, always "channel".
  property type : String

  # Date the message was sent originally in Unix time.
  property date : Int32

  # Channel chat to which the message was originally sent.
  property chat : Hamilton::Types::Chat

  # Unique message identifier inside the chat.
  property message_id : Int32

  # Signature of the original post author.
  property author_signature : String | Nil
end

# This object describes the origin of a message.
alias Hamilton::Types::MessageOrigin = Hamilton::Types::MessageOriginUser | Hamilton::Types::MessageOriginHiddenUser | Hamilton::Types::MessageOriginChannel | Hamilton::Types::MessageOriginUser