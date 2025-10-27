require "json"
require "./utils.cr"

# Describes a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Checklist
  include JSON::Serializable
  include Hamilton::Types::Common

  # Title of the checklist.
  property title : String

  # Special entities that appear in the checklist title.
  property title_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # List of tasks in the checklist.
  property tasks : Array(Hamilton::Types::ChecklistTask)

  # True, if users other than the creator of the list can add tasks to the list.
  property others_can_add_tasks : Bool | Nil

  # True, if users other than the creator of the list can mark tasks as done or not done.
  property others_can_mark_tasks_as_done : Bool | Nil
end