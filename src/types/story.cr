require "json"

# This object represents a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Story
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

  # Chat that posted the story
  property chat : Hamilton::Types::Chat
  
  # Unique identifier for the story in the chat.
  property id : Int32
end