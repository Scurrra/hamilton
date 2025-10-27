require "json"
require "./utils.cr"

# Describes a service message about the failed approval of a suggested post. Currently, only caused by insufficient user funds at the time of approval.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostApprovalFailed
  include JSON::Serializable
  include Hamilton::Types::Common
  
  # Message containing the suggested post whose approval has failed. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Expected price of the post.
  property price : Hamilton::Types::SuggestedPostPrice
end