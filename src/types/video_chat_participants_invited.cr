require "json"

# This object represents a service message about new members invited to a video chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatParticipantsInvited
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

  # New members that were invited to the video chat.
  property users : Array(Hamilton::Types::User)
end