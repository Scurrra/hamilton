require "json"

# Describes the opening hours of a business.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessOpeningHours
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

  # Unique name of the time zone for which the opening hours are defined.
  property time_zone_name : String

  # List of time intervals describing business opening hours.
  property opening_hours : Array(Hamilton::Types::BusinessOpeningHoursInterval)
end