require "json"
require "./utils.cr"

# This object represents a portion of the price for goods or services.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LabeledPrice
  include JSON::Serializable
  include Hamilton::Types::Common

  # Portion label.
  property label : String

  # Price of the product in the smallest units of the currency (integer, not float/double).
  property amount : Int32
end