require "json"
require "./utils.cr"

# This object describes the symbol shown on the pattern of a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftSymbol
  include Hamilton::Types::Common

  # Name of the model.
  property name : String

  # The sticker that represents the unique gift.
  property sticker : Hamilton::Types::Sticker

  # The number of unique gifts that receive this model for every 1000 gifts upgraded.
  property rarity_per_mille : Int32
end