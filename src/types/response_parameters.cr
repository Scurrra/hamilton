require "json"
require "./utils.cr"

# Describes why a request was unsuccessful.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ResponseParameters
  include JSON::Serializable
  include Hamilton::Types::Common

  # The group has been migrated to a supergroup with the specified identifier.
  property migrate_to_chat_id : Int64 | Nil

  # In case of exceeding flood control, the number of seconds left to wait before the request can be repeated.
  property retry_after : Int32
end