require "json"

# This object represents a portion of the price for goods or services.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LabeledPrice
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

  # Portion label.
  property label : String

  # Price of the product in the smallest units of the currency (integer, not float/double).
  property amount : Int32
end