require "json"

# This object contains information about the quoted part of a message that is replied to by the given message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::TextQuote
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

  # Text of the quoted part of a message that is replied to by the given message.
  property text : String

  # Special entities that appear in the quote. Currently, only bold, italic, underline, strikethrough, spoiler, and custom_emoji entities are kept in quotes.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Approximate quote position in the original message in UTF-16 code units as specified by the sender.
  property position : Int32

  # True, if the quote was chosen manually by the message sender. Otherwise, the quote was added automatically by the server.
  property is_manual : Bool | Nil
end