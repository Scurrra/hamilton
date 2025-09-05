require "json"
require "./utils.cr"

# This object represents one shipping option.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingOption
  include Hamilton::Types::Common

  # Shipping option identifier.
  property id : String

  # Option title.
  property title : String

  # List of price portions.
  property prices : Array(Hamilton::Types::LabeledPrice)
end