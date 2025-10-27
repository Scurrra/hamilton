require "json"
require "./utils.cr"

# This object represents a service message about a change in auto-delete timer settings.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageAutoDeleteTimerChanged
  include JSON::Serializable
  include Hamilton::Types::Common

  # New auto-delete time for messages in the chat; in seconds.
  property message_auto_delete_time : Int32
end