require "json"
require "./utils.cr"

# This object is received when messages are deleted from a connected business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessMessagesDeleted
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the business connection.
  property business_connection_id : String

  # Information about a chat in the business account. The bot may not have access to the chat or the corresponding user.
  property chat : Hamilton::Types::Chat

  # The list of identifiers of deleted messages in the chat of the business account.
  property message_ids : Array(Int32)
end