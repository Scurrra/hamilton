require "json"

# This object represents a service message about a video chat scheduled in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatScheduled
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

  # Point in time (Unix timestamp) when the video chat is supposed to be started by a chat administrator.
  property start_date : Int32
end