require "json"
require "./utils.cr"

# This object represents a unique message identifier.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageId
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique message identifier. In specific instances (e.g., message containing a video sent to a big chat), the server might automatically schedule a message instead of sending it immediately. In such cases, this field will be 0 and the relevant message will be unusable until it is actually sent.
  property message_id : Int32
end