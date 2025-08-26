require "json"

# This object represents one shipping option.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ShippingOption
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

  # Shipping option identifier.
  property id : String

  # Option title.
  property title : String

  # List of price portions.
  property prices : Array(Hamilton::Types::LabeledPrice)
end