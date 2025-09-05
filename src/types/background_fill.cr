require "json"
require "./utils.cr"

# The background is filled using the selected color.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundFillSolid
  include Hamilton::Types::Common

  # Type of the background fill, always “solid”.
  property type : String

  # The color of the background fill in the RGB24 format.
  property color : Int32
end

# The background is a gradient fill.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundFillGradient
  include Hamilton::Types::Common

  # Type of the background fill, always "gradient".
  property type : String

  # Top color of the gradient in the RGB24 format.
  property top_color : Int32

  # Bottom color of the gradient in the RGB24 format.
  property bottom_color : Int32

  # Clockwise rotation angle of the background fill in degrees; 0-359.
  property rotation_angle : Int32
end

# The background is a freeform gradient that rotates after every message in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BackgroundFillFreeformGradient
  include Hamilton::Types::Common

  # Type of the background fill, always "freeform_gradient".
  property type : String

  # A list of the 3 or 4 base colors that are used to generate the freeform gradient in the RGB24 format.
  property colors : Array(Int32)
end

# This object describes the way a background is filled based on the selected colors.
alias Hamilton::Types::BackgroundFill = Hamilton::Types::BackgroundFillSolid | Hamilton::Types::BackgroundFillGradient | Hamilton::Types::BackgroundFillFreeformGradient