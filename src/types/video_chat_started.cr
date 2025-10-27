require "json"
require "./utils.cr"

# This object represents a service message about a video chat started in the chat. Currently holds no information.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatStarted
  include JSON::Serializable
  include Hamilton::Types::Common
end