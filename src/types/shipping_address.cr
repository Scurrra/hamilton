require "json"
require "./utils.cr"

# This object represents a shipping address.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingAddress
  include Hamilton::Types::Common

  # Two-letter ISO 3166-1 alpha-2 country code.
  property country_code : String

  # State, if applicable.
  property state : String

  # City.
  property city : String

  # First line for the address.
  property street_line1 : String

  # Second line for the address.
  property street_line2 : String

  # Address post code.
  property post_code : String
end