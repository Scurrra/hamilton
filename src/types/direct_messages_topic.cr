require "json"
require "./utils.cr"

# Describes a topic of a direct messages chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::DirectMessagesTopic
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the topic
  property topic_id : Int32

  # Information about the user that created the topic. Currently, it is always present.
  property user : Hamilton::Types::User | Nil
end