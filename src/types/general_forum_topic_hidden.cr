require "json"
require "./utils.cr"

# This object represents a service message about General forum topic hidden in the chat. Currently holds no information.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GeneralForumTopicHidden
  include Hamilton::Types::Common
end