require "json"
require "./utils.cr"

# This object contains information about an incoming shipping query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingQuery
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique query identifier.
  property id : String

  # User who sent the query.
  property from : Hamilton::Types::User

  # Bot-specified invoice payload.
  property invoice_payload : String

  # User specified shipping address.
  property shipping_address : Hamilton::Types::ShippingAddress
end