require "json"

# Represents a chat member that owns the chat and has all administrator privileges.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberOwner
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

  # The member's status in the chat, always “creator”.
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User

  # True, if the user's presence in the chat is hidden.
  property is_anonymous : Bool

  # Custom title for this user.
  property custom_title : String | Nil
end

# Represents a chat member that has some additional privileges.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberAdministrator
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

  # The member's status in the chat, always "administrator".
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User

  # True, if the bot is allowed to edit administrator privileges of that user.
  property can_be_edited : Bool

  # True, if the user's presence in the chat is hidden.
  property is_anonymous : Bool

  # True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages, ignore slow mode, and send messages to the chat without paying Telegram Stars. Implied by any other administrator privilege.
  property can_manage_chat : Bool

  # True, if the administrator can delete messages of other users.
  property can_delete_messages : Bool

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

  # Custom title for this user.
  property custom_title : String | Nil
end

# Represents a chat member that has no additional privileges or restrictions.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberMember
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

  # The member's status in the chat, always "member".
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User

  # Date when the user's subscription will expire; Unix time.
  property until_date : Int32 | Nil
end

# Represents a chat member that is under certain restrictions in the chat. Supergroups only.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberRestricted
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

  # The member's status in the chat, always "restricted".
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User

  # True, if the user is a member of the chat at the moment of the request.
  property is_member : Bool

  # True, if the user is allowed to send text messages, contacts, giveaways, giveaway winners, invoices, locations and venues.
  property can_send_messages : Bool

  # True, if the user is allowed to send audios.
  property can_send_audios : Bool

  # True, if the user is allowed to send documents.
  property can_send_documents : Bool

  # True, if the user is allowed to send photos.
  property can_send_photos : Bool

  # True, if the user is allowed to send videos.
  property can_send_videos : Bool

  # True, if the user is allowed to send video notes.
  property can_send_video_notes : Bool

  # True, if the user is allowed to send voice notes.
  property can_send_voice_notes : Bool

  # True, if the user is allowed to send polls and checklists.
  property can_send_polls : Bool

  # True, if the user is allowed to send animations, games, stickers and use inline bots.
  property can_send_other_messages : Bool

  # True, if the user is allowed to add web page previews to their messages.
  property can_add_web_page_previews : Bool

  # True, if the user is allowed to change the chat title, photo and other settings.
  property can_change_info : Bool

  # True, if the user is allowed to invite new users to the chat.
  property can_invite_users : Bool

  # True, if the user is allowed to pin messages.
  property can_pin_messages : Bool

  # True, if the user is allowed to create forum topics.
  property can_manage_topics : Bool

  # Date when restrictions will be lifted for this user; Unix time. If 0, then the user is restricted forever
  property until_date : Int32
end

# Represents a chat member that isn't currently a member of the chat, but may join it themselves.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberLeft
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

  # The member's status in the chat, always "left".
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User
end

# Represents a chat member that was banned in the chat and can't return to the chat or view chat messages.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatMemberBanned
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

  # The member's status in the chat, always "kicked".
  property status : String

  # Information about the user.
  property user : Hamilton::Types::User

  # Date when restrictions will be lifted for this user; Unix time. If 0, then the user is banned forever
  property until_date : Int32
end

# This object contains information about one member of a chat.
alias Hamilton::Types::ChatMember = Hamilton::Types::ChatMemberOwner | Hamilton::Types::ChatMemberAdministrator | Hamilton::Types::ChatMemberMember | Hamilton::Types::ChatMemberRestricted | Hamilton::Types::ChatMemberLeft | Hamilton::Types::ChatMemberBanned