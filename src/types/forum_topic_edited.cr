require "json"

# This object represents a service message about an edited forum topic.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ForumTopicEdited
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

  # New name of the topic, if it was edited.
  property name : String | Nil

  # New identifier of the custom emoji shown as the topic icon, if it was edited; an empty string if the icon was removed.
  property icon_custom_emoji_id : String | Nil
end