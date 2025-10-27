require "json"
require "./utils.cr"

# This object describes the backdrop of a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftBackdrop
  include JSON::Serializable
  include Hamilton::Types::Common

  # Name of the model.
  property name : String

  # Colors of the backdrop.
  property colors : Hamilton::Types::UniqueGiftBackdropColors

  # The number of unique gifts that receive this backdrop for every 1000 gifts upgraded.
  property rarity_per_mille : Int32
end