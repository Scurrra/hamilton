require "json"
require "./utils.cr"

# This object represents a service message about a forum topic closed in the chat. Currently holds no information.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopicClosed
  include Hamilton::Types::Common
end