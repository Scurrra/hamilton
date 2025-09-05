require "json"
require "./utils.cr"

# Describes a task to add to a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputChecklistTask
  include Hamilton::Types::Common

  # Unique identifier of the task; must be positive and unique among all task identifiers currently present in the checklist.
  property id : Int32

  # Text of the task; 1-100 characters after entities parsing.
  property text : String

  # Mode for parsing entities in the text.
  property parse_mode : String | Nil

  # List of special entities that appear in the text, which can be specified instead of parse_mode. Currently, only bold, italic, underline, strikethrough, spoiler, and custom_emoji entities are allowed.
  property text_entities : Array(Hamilton::Types::MessageEntity)
end