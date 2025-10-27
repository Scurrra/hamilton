require "json"
require "./utils.cr"

# This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ProximityAlertTriggered
  include JSON::Serializable
  include Hamilton::Types::Common

  # User that triggered the alert.
  property traveler : Hamilton::Types::User

  # User that set the alert.
  property watcher : Hamilton::Types::User

  # The distance between the users.
  property distance : Int32
end