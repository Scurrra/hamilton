require "json"
require "./utils.cr"

# This object describes a unique gift that was upgraded from a regular gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGift
  include JSON::Serializable
  include Hamilton::Types::Common

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

  # Information about the chat that published the gift.
  property publisher_chat : Hamilton::Types::Chat
end