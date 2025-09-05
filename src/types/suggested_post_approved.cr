require "json"
require "./utils.cr"

# Describes a service message about the approval of a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostApproved
  include Hamilton::Types::Common

  # Message containing the suggested post. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Amount paid for the post.
  property price : Hamilton::Types::SuggestedPostPrice | Nil

  # Date when the post will be published.
  property send_date : Int32
end