require "json"
require "./utils.cr"

# Describes a service message about a successful payment for a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostPaid
  include JSON::Serializable
  include Hamilton::Types::Common
  
  # Message containing the suggested post. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Currency in which the payment was made. Currently, one of “XTR” for Telegram Stars or “TON” for toncoins.
  property currency : String

  # The amount of the currency that was received by the channel in nanotoncoins; for payments in toncoins only.
  property amount : Int32 | Nil

  # The amount of Telegram Stars that was received by the channel; for payments in Telegram Stars only.
  property star_amount : Hamilton::Types::StarAmount
end