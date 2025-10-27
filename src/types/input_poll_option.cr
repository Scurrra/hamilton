require "json"
require "./utils.cr"

# This object contains information about one answer option in a poll to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputPollOption
  include JSON::Serializable
  include Hamilton::Types::Common

  # Option text, 1-100 characters.
  property text : String

  # Mode for parsing entities in the text. See formatting options for more details. Currently, only custom emoji entities are allowed.
  property text_parse_mode : String | Nil

  # A JSON-serialized list of special entities that appear in the poll option text. It can be specified instead of text_parse_mode.
  property text_entities : Array(Hamilton::Types::MessageEntity)
end