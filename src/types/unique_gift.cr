require "json"
require "./utils.cr"

# This object describes a unique gift that was upgraded from a regular gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGift
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier of the regular gift from which the gift was upgraded.
  property gift_id : String

  # Human-readable name of the regular gift from which this unique gift was upgraded.
  property base_name : String

  # Unique name of the gift. This name can be used in `https://t.me/nft/...` links and story areas.
  property name : String

  # Unique number of the upgraded gift among gifts upgraded from the same regular gift.
  property number : Int32

  # Model of the gift.
  property model : Hamilton::Types::UniqueGiftModel

  # Symbol of the gift.
  property symbol : Hamilton::Types::UniqueGiftSymbol

  # Backdrop of the gift.
  property backdrop : Hamilton::Types::UniqueGiftBackdrop

  # True, if the original regular gift was exclusively purchaseable by Telegram Premium subscribers.
  property is_premium : Bool | Nil

  # True, if the gift is assigned from the TON blockchain and can't be resold or transferred in Telegram.
  property is_from_blockchain : Bool | Nil

  # The color scheme that can be used by the gift's owner for the chat's name, replies to messages and link previews; for business account gifts and gifts that are currently on sale only.
  property colors : Hamilton::Types::UniqueGiftColors | Nil

  # Information about the chat that published the gift.
  property publisher_chat : Hamilton::Types::Chat
end
