require "json"
require "./utils.cr"

# This object describes the background of a gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiftBackground
  include JSON::Serializable
  include Hamilton::Types::Common

  # Center color of the background in RGB format.
  property center_color : Int32

  # Edge color of the background in RGB format.
  property edge_color : Int32

  # Text color of the background in RGB format.
  property text_color : Int32
end
