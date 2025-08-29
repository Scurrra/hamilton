require "json"

# Describes the position of a clickable area within a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaPosition
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

  # The abscissa of the area's center, as a percentage of the media width.
  property x_percentage : Float32

  # The ordinate of the area's center, as a percentage of the media height.
  property y_percentage : Float32

  # The width of the area's rectangle, as a percentage of the media width.
  property width_percentage : Float32

  # The height of the area's rectangle, as a percentage of the media height.
  property height_percentage : Float32

  # The clockwise rotation angle of the rectangle, in degrees; 0-360.
  property rotation_angle : Float32

  # The radius of the rectangle corner rounding, as a percentage of the media width.
  property corner_radius_percentage : Float32
end