require "json"
require "./utils.cr"

# Describes the position of a clickable area within a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryAreaPosition
  include Hamilton::Types::Common

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