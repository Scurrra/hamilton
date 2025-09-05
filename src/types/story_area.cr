require "json"
require "./utils.cr"

# Describes a clickable area on a story media.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryArea
  include Hamilton::Types::Common

  # Position of the area.
  property position : Hamilton::Types::StoryAreaPosition

  # Type of the area.
  property type : Hamilton::Types::StoryAreaType
end