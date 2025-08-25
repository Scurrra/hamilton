require "json"

# Describes the physical address of a location.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LocationAddress
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

  # The two-letter ISO 3166-1 alpha-2 country code of the country where the location is located.
  property country_code : String

  # State of the location.
  property state : String | Nil

  # City of the location.
  property city : String | Nil

  # Street address of the location.
  property street : String | Nil
end