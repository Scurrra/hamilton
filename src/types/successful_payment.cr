require "json"
require "./utils.cr"

# This object contains basic information about a successful payment. Note that if the buyer initiates a chargeback with the relevant payment provider following this transaction, the funds may be debited from your balance. This is outside of Telegram's control.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuccessfulPayment
  include JSON::Serializable
  include Hamilton::Types::Common

  # Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars.
  property currency : String

  # Total price in the smallest units of the currency (integer, not float/double)..
  property total_amount : Int32

  # Bot-specified invoice payload.
  property invoice_payload : String

  # Expiration date of the subscription, in Unix time; for recurring payments only.
  property subscription_expiration_date : Int32 | Nil

  # True, if the payment is a recurring payment for a subscription.
  property is_recurring : Bool | Nil

  # True, if the payment is the first payment for a subscription.
  property is_first_recurring : Bool | Nil

  # Identifier of the shipping option chosen by the user.
  property shipping_option_id : String | Nil

  # Order information provided by the user.
  property order_info : Hamilton::Types::OrderInfo

  # Telegram payment identifier.
  property telegram_payment_charge_id : String

  # Provider payment identifier.
  property provider_payment_charge_id : String
end