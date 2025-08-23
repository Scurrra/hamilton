require "json"

# Describes a service message about checklist tasks marked as done or not done.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTasksDone
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

  # Message containing the checklist whose tasks were marked as done or not done. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property checklist_message : Hamilton::Types::Message | Nil

  # Identifiers of the tasks that were marked as done.
  property marked_as_done_task_ids : Array(Int32)

  # Identifiers of the tasks that were marked as not done.
  property marked_as_not_done_task_ids Array(Int32)
end