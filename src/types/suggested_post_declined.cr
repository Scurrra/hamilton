require "json"
require "./utils.cr"

# Describes a service message about the rejection of a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostDeclined
  include Hamilton::Types::Common
  
  # Message containing the suggested post. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Comment with which the post was declined.
  property comment : String | Nil
end