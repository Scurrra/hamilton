require "json"

# This object contains information about a message that is being replied to, which may come from another chat or forum topic.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ExternalReplyInfo
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

  # Origin of the message replied to by the given message.
  property origin : Hamilton::Types::MessageOrigin

  # Chat the original message belongs to. Available only if the chat is a supergroup or a channel.
  property chat : Hamilton::Types::Chat | Nil

  # Unique message identifier inside the original chat. Available only if the original chat is a supergroup or a channel.
  property message_id : Int32 | Nil

  # Options used for link preview generation for the original message, if it is a text message.
  property link_preview_options : Hamilton::Types::LinkPreviewOptions | Nil

  # Message is an animation, information about the animation.
  property animation : Hamilton::Types::Animation | Nil

  # Message is an audio file, information about the file.
  property audio : Hamilton::Types::Audio | Nil

  # Message is a general file, information about the file.
  property document : Hamilton::Types::Document | Nil

  # Message contains paid media; information about the paid media.
  property paid_media : Hamilton::Types::PaidMediaInfo | Nil

  # Message is a photo, available sizes of the photo.
  property photo : Array(Hamilton::Types::PhotoSize) | Nil

  # Message is a sticker, information about the sticker.
  property sticker : Hamilton::Types::Sticker | Nil

  # Message is a forwarded story.
  property story : Hamilton::Types::Story | Nil

  # Message is a video, information about the video.
  property video : Hamilton::Types::Video | Nil

  # Message is a video note, information about the video message.
  property video_note : Hamilton::Types::VideoNote | Nil

  # Message is a voice message, information about the file.
  property voice : Hamilton::Types::Voice | Nil

  # True, if the message media is covered by a spoiler animation.
  property has_media_spoiler : Bool | Nil

  # Message is a checklist.
  property checklist : Hamilton::Types::Checklist | Nil

  # Message is a shared contact, information about the contact.
  property contact : Hamilton::Types::Contact | Nil

  # Message is a dice with random value.
  property dice : Hamilton::Types::Dice | Nil

  # Message is a game, information about the game.
  property game : Hamilton::Types::Game | Nil

  # Message is a scheduled giveaway, information about the giveaway.
  property giveaway : Hamilton::Types::Giveaway | Nil

  # A giveaway with public winners was completed.
  property giveaway_winners : Hamilton::Types::GiveawayWinners | Nil

  # Message is an invoice for a payment, information about the invoice.
  property invoice : Hamilton::Types::Invoice | Nil

  # Message is a shared location, information about the location.
  property location : Hamilton::Types::Location | Nil

  # Message is a native poll, information about the poll.
  property poll : Hamilton::Types::Poll | Nil

  # Message is a venue, information about the venue.
  property venue : Hamilton::Types::Venue | Nil
end