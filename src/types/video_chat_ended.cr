require "json"
require "./utils.cr"

# This object represents a service message about a video chat ended in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatEnded
  include Hamilton::Types::Common

  # Video chat duration in seconds.
  property duration : Int32
end