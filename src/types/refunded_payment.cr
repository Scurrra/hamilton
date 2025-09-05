require "json"
require "./utils.cr"

# This object contains basic information about a refunded payment.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::RefundedPayment
  include Hamilton::Types::Common

  # Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars. Currently, always “XTR”.
  property currency : String

  # Total refunded price in the smallest units of the currency (integer, not float/double).
  property total_amount : Int32

  # Bot-specified invoice payload.
  property invoice_payload : String

  # Telegram payment identifier.
  property telegram_payment_charge_id : String

  # Provider payment identifier.
  property provider_payment_charge_id : String | Nil
end