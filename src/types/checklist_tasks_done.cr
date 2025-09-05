require "json"
require "./utils.cr"

# Describes a service message about checklist tasks marked as done or not done.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTasksDone
  include Hamilton::Types::Common

  # Message containing the checklist whose tasks were marked as done or not done. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property checklist_message : Hamilton::Types::Message | Nil

  # Identifiers of the tasks that were marked as done.
  property marked_as_done_task_ids : Array(Int32)

  # Identifiers of the tasks that were marked as not done.
  property marked_as_not_done_task_ids : Array(Int32)
end