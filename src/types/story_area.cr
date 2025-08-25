require "json"

# Describes a clickable area on a story media.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StoryArea
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

  # Position of the area.
  property position : Hamilton::Types::StoryAreaPosition

  # Type of the area.
  property type : Hamilton::Types::StoryAreaType
end