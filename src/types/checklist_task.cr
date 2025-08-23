require "json"

# Describes a task in a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTask
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

  # Unique identifier of the task
  property id : Int32

  # Text of the task
  property text : String

  # Special entities that appear in the task text.
  property text_entities : Array(Hamilton::Types::MessageEntity)

  # User that completed the task; omitted if the task wasn't completed.
  property completed_by_user : Hamilton::Types::User

  # Point in time (Unix timestamp) when the task was completed; 0 if the task wasn't completed.
  property completion_date : Int32
end