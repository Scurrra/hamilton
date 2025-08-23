require "json"

# This object represents a point on the map.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Location
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

  # Latitude as defined by the sender.
  property latitude : Float32

  # Longitude as defined by the sender.
  property longitude : Float32

  # The radius of uncertainty for the location, measured in meters; 0-1500.
  property horizontal_accuracy : Float32 | Nil

  # Time relative to the message sending date, during which the location can be updated; in seconds. For active live locations only.
  property live_period : Int32 | Nil

  # The direction in which user is moving, in degrees; 1-360. For active live locations only.
  property heading : Int32 | Nil

  # The maximum distance for proximity alerts about approaching another chat member, in meters. For sent live locations only.
  property proximity_alert_radius : Int32 | Nil
end