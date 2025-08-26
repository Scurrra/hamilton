require "json"

# This object represents a shipping address.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingAddress
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

  # Two-letter ISO 3166-1 alpha-2 country code.
  property country_code : String

  # State, if applicable.
  property state : String

  # City.
  property city : String

  # First line for the address.
  property street_line1 : String

  # Second line for the address.
  property street_line2 : String

  # Address post code.
  property post_code : String
end