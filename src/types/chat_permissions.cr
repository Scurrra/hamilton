require "json"

# Describes actions that a non-administrator user is allowed to take in a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatPermissions
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

  # True, if the user is allowed to send text messages, contacts, giveaways, giveaway winners, invoices, locations and venues.
  property can_send_messages : Bool | Nil

  # True, if the user is allowed to send audios.
  property can_send_audios : Bool | Nil

  # True, if the user is allowed to send documents.
  property can_send_documents : Bool | Nil

  # True, if the user is allowed to send photos.
  property can_send_photos : Bool | Nil

  # True, if the user is allowed to send videos.
  property can_send_videos : Bool | Nil

  # True, if the user is allowed to send video notes.
  property can_send_video_notes : Bool | Nil

  # True, if the user is allowed to send voice notes.
  property can_send_voice_notes : Bool | Nil

  # True, if the user is allowed to send polls and checklists.
  property can_send_polls : Bool | Nil

  # True, if the user is allowed to send animations, games, stickers and use inline bots.
  property can_send_other_messages : Bool | Nil

  # True, if the user is allowed to add web page previews to their messages.
  property can_add_web_page_previews : Bool | Nil

  # True, if the user is allowed to change the chat title, photo and other settings. Ignored in public supergroups.
  property can_change_info : Bool | Nil

  # True, if the user is allowed to invite new users to the chat.
  property can_invite_users : Bool | Nil

  # True, if the user is allowed to pin messages. Ignored in public supergroups.
  property can_pin_messages : Bool | Nil

  # True, if the user is allowed to create forum topics. If omitted defaults to the value of `can_pin_messages`.
  property can_manage_topics : Bool | Nil
end