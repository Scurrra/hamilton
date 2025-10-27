require "json"
require "./utils.cr"

# This object contains basic information about an invoice.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Invoice
  include JSON::Serializable
  include Hamilton::Types::Common

  # Product name.
  property title : String

  # Product description.
  property decription : String

  # Unique bot deep-linking parameter that can be used to generate this invoice.
  property start_parameter : String

  # Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars.
  property currency : String

  # Total price in the smallest units of the currency (integer, not float/double).
  property total_amount : Int32
end