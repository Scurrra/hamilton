require "json"

# This object contains basic information about an invoice.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Invoice
  include JSON::Serializable

  # List of available non-nil fields.
  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  # :nodoc:
  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

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