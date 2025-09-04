require "json"

# Represents the rights of an administrator in a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatAdministratorRights
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

  # True, if the user's presence in the chat is hidden.
  property is_anonymous : Bool

  # True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages, ignore slow mode, and send messages to the chat without paying Telegram Stars. Implied by any other administrator privilege.
  property can_manage_chat : Bool

  # True, if the administrator can delete messages of other users.
  property can_delete_messages : Bool

  # True, if the administrator can manage video chats.
  property can_manage_video_chats : Bool

  # True, if the administrator can manage video chats.
  property can_manage_video_chats : Bool

  # True, if the administrator can restrict, ban or unban chat members, or access supergroup statistics.
  property can_restrict_members : Bool

  # True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by the user).
  property can_promote_members : Bool

  # True, if the user is allowed to change the chat title, photo and other settings.
  property can_change_info : Bool

  # True, if the user is allowed to invite new users to the chat.
  property can_invite_users : Bool

  # True, if the administrator can post stories to the chat.
  property can_post_stories : Bool

  # True, if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive.
  property can_edit_stories : Bool

  # True, if the administrator can delete stories posted by other users.
  property can_delete_stories : Bool

  # True, if the administrator can post messages in the channel, approve suggested posts, or access channel statistics; for channels only.
  property can_post_messages : Bool | Nil

  # True, if the administrator can edit messages of other users and can pin messages; for channels only.
  property can_edit_messages : Bool | Nil

  # True, if the user is allowed to pin messages; for groups and supergroups only.
  property can_pin_messages : Bool | Nil

  # True, if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only.
  property can_manage_topics : Bool | Nil

  # True, if the administrator can manage direct messages of the channel and decline suggested posts; for channels only.
  property can_manage_direct_messages : Bool | Nil
end