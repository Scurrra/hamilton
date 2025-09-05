require "json"
require "./utils.cr"

# This object represents changes in the status of a chat member.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberUpdated
  include Hamilton::Types::Common

  # Chat the user belongs to.
  property chat : Hamilton::Types::Chat

  # Performer of the action, which resulted in the change.
  property from : Hamilton::Types::User

  # Date the change was done in Unix time.
  property date : Int32

  # Previous information about the chat member.
  property old_chat_member : Hamilton::Types::ChatMember

  # New information about the chat member.
  property new_chat_member : Hamilton::Types::ChatMember

  # Chat invite link, which was used by the user to join the chat; for joining by invite link events only.
  property invite_link : Hamilton::Types::ChatInviteLink | Nil

  # True, if the user joined the chat after sending a direct join request without using an invite link and being approved by an administrator.
  property via_join_request : Bool | Nil

  # True, if the user joined the chat via a chat folder invite link.
  property via_chat_folder_invite_link : Bool | Nil
end