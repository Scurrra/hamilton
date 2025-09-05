require "json"
require "./utils.cr"

# This object represents a service message about a video chat scheduled in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatScheduled
  include Hamilton::Types::Common

  # Point in time (Unix timestamp) when the video chat is supposed to be started by a chat administrator.
  property start_date : Int32
end