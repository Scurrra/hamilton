require "json"
require "./utils.cr"

# Describes a service message about a regular gift that was sent or received.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiftInfo
  include JSON::Serializable
  include Hamilton::Types::Common

  # Information about the gift.
  property gift : Hamilton::Types::Gift

  # Unique identifier of the received gift for the bot; only present for gifts received on behalf of business accounts.
  property owned_gift_id : String | Nil

  # Number of Telegram Stars that can be claimed by the receiver by converting the gift; omitted if conversion to Telegram Stars is impossible.
  property convert_star_count : Int32 | Nil

  # Number of Telegram Stars that were prepaid by the sender for the ability to upgrade the gift.
  property prepaid_upgrade_star_count : Int32 | Nil

  # True, if the gift's upgrade was purchased after the gift was sent.
  property is_upgrade_separate : Bool | Nil

  # True, if the gift can be upgraded to a unique gift.
  property can_be_upgraded : Bool | Nil

  # Text of the message that was added to the gift.
  property text : String | Nil

  # Special entities that appear in the text.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # True, if the sender and gift text are shown only to the gift receiver; otherwise, everyone will be able to see them.
  property is_private : Bool | Nil

  # Unique number reserved for this gift when upgraded. See the number field in `Hamilton::Types::UniqueGift`.
  property unique_gift_number : Int32 | Nil
end
