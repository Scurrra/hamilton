require "json"
require "./utils.cr"

# This object represents information about an order.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::OrderInfo
  include JSON::Serializable
  include Hamilton::Types::Common

  # User name.
  property name : String | Nil

  # User's phone number.
  property phone_number : String | Nil

  # User email.
  property email : String | Nil

  # User shipping address.
  property shipping_address : Hamilton::Types::ShippingAddress | Nil
end