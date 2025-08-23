require "json"

# This object contains information about one answer option in a poll to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputPollOption
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

  # Option text, 1-100 characters.
  property text : String

  # Mode for parsing entities in the text. See formatting options for more details. Currently, only custom emoji entities are allowed.
  property text_parse_mode : String | Nil

  # A JSON-serialized list of special entities that appear in the poll option text. It can be specified instead of text_parse_mode.
  property text_entities : Array(Hamilton::Types::MessageEntity)
end