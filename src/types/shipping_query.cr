require "json"

# This object contains information about an incoming shipping query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingQuery
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

  # Unique query identifier.
  property id : String

  # User who sent the query.
  property from : Hamilton::Types::User

  # Bot-specified invoice payload.
  property invoice_payload : String

  # User specified shipping address.
  property shipping_address : Hamilton::Types::ShippingAddress
end