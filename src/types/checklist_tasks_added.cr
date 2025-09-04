require "json"

# Describes a service message about tasks added to a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTasksAdded
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

  # Message containing the checklist to which the tasks were added. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property checklist_message : Hamilton::Types::Message | Nil

  # List of tasks added to the checklist.
  property tasks : Array(Hamilton::Types::ChecklistTask)
end