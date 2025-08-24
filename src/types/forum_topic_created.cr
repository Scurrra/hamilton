require "json"

# This object represents a service message about a new forum topic created in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopicCreated
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

  # Name of the topic.
  property name : String

  # Color of the topic icon in RGB format.
  property icon_color : Int32

  # Unique identifier of the custom emoji shown as the topic icon.
  property icon_custom_emoji_id : String | Nil
end