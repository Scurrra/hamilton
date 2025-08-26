require "json"

# This object contains basic information about a refunded payment.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::RefundedPayment
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

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