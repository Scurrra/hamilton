require "json"

# This object represents a service message about a change in auto-delete timer settings.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageAutoDeleteTimerChanged
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

  # New auto-delete time for messages in the chat; in seconds.
  property message_auto_delete_time : Int32
end