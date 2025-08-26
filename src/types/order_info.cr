require "json"

# This object represents information about an order.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::OrderInfo
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

  # User name.
  property name : String | Nil

  # User's phone number.
  property phone_number : String | Nil

  # User email.
  property email : String | Nil

  # User shipping address.
  property shipping_address : Hamilton::Types::ShippingAddress | Nil
end