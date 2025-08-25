require "json"

# Represents a location to which a chat is connected.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatLocation
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

  # The location to which the supergroup is connected. Can't be a live location.
  property location : Hamilton::Types::Location

  # Location address; 1-64 characters, as defined by the chat owner.
  property address : String
end