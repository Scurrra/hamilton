require "json"
require "./utils.cr"

# Describes the physical address of a location.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LocationAddress
  include Hamilton::Types::Common

  # The two-letter ISO 3166-1 alpha-2 country code of the country where the location is located.
  property country_code : String

  # State of the location.
  property state : String | Nil

  # City of the location.
  property city : String | Nil

  # Street address of the location.
  property street : String | Nil
end