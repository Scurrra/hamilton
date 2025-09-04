require "json"

# Describes a topic of a direct messages chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::DirectMessagesTopic
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

  # Unique identifier of the topic
  property topic_id : Int32

  # Information about the user that created the topic. Currently, it is always present.
  property user : Hamilton::Types::User | Nil
end