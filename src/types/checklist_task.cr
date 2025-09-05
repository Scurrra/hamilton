require "json"
require "./utils.cr"

# Describes a task in a checklist.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChecklistTask
  include Hamilton::Types::Common

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