require "json"
require "./utils.cr"

# Describes a service message about tasks added to a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTasksAdded
  include Hamilton::Types::Common

  # Message containing the checklist to which the tasks were added. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property checklist_message : Hamilton::Types::Message | Nil

  # List of tasks added to the checklist.
  property tasks : Array(Hamilton::Types::ChecklistTask)
end