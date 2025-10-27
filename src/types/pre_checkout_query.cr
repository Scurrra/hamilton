require "json"
require "./utils.cr"

# This object contains information about an incoming pre-checkout query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PreCheckoutQuery
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique query identifier.
  property id : String

  # User who sent the query.
  property from : Hamilton::Types::User

  # Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars.
  property currency : String

  # Total price in the smallest units of the currency (integer, not float/double).
  property total_amount : Int32

  # Bot-specified invoice payload.
  property invoice_payload : String

  # Identifier of the shipping option chosen by the user.
  property shipping_option_id : String | Nil

  # Order information provided by the user.
  property order_info : Hamilton::Types::OrderInfo | Nil
end