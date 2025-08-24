require "json"

# This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ProximityAlertTriggered
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

  # User that triggered the alert.
  property traveler : Hamilton::Types::User

  # User that set the alert.
  property watcher : Hamilton::Types::User

  # The distance between the users.
  property distance : Int32
end