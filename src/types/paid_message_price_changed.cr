require "json"
require "./utils.cr"

# Describes a service message about a change in the price of paid messages within a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMessagePriceChanged
  include JSON::Serializable
  include Hamilton::Types::Common

  # The new number of Telegram Stars that must be paid by non-administrator users of the supergroup chat for each sent message.
  property paid_message_star_count : Int32
end