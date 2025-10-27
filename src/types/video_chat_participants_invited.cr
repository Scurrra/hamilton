require "json"
require "./utils.cr"

# This object represents a service message about new members invited to a video chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoChatParticipantsInvited
  include JSON::Serializable
  include Hamilton::Types::Common

  # New members that were invited to the video chat.
  property users : Array(Hamilton::Types::User)
end