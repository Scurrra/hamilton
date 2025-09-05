require "json"
require "./utils.cr"

# This object represents a message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Message
  include Hamilton::Types::Common

  # Unique message identifier inside this chat. In specific instances (e.g., message containing a video sent to a big chat), the server might automatically schedule a message instead of sending it immediately. In such cases, this field will be 0 and the relevant message will be unusable until it is actually sent.
  property message_id : Int32

  # Unique identifier of a message thread to which the message belongs; for supergroups only.
  property message_thread_id : Int32 | Nil

  # Information about the direct messages chat topic that contains the message.
  property direct_messages_topic : Hamilton::Types::DirectMessagesTopic | Nil

  # Sender of the message; may be empty for messages sent to channels. For backward compatibility, if the message was sent on behalf of a chat, the field contains a fake sender user in non-channel chats.
  property from : Hamilton::Types::User | Nil

  # Sender of the message when sent on behalf of a chat. For example, the supergroup itself for messages sent by its anonymous administrators or a linked channel for messages automatically forwarded to the channel's discussion group. For backward compatibility, if the message was sent on behalf of a chat, the field from contains a fake sender user in non-channel chats.
  property sender_chat : Hamilton::Types::Chat | Nil

  # If the sender of the message boosted the chat, the number of boosts added by the user.
  property sender_boost_count : Int32 | Nil

  # The bot that actually sent the message on behalf of the business account. Available only for outgoing messages sent on behalf of the connected business account.
  property sender_business_bot : Hamilton::Types::User | Nil

  # Date the message was sent in Unix time. It is always a positive number, representing a valid date.
  property date : Int32

  # Unique identifier of the business connection from which the message was received. If non-empty, the message belongs to a chat of the corresponding business account that is independent from any potential bot chat which might share the same identifier.
  property business_connection_id : String | Nil

  # Chat the message belongs to.
  property chat : Hamilton::Types::Chat

  # Information about the original message for forwarded messages.
  property forward_origin : Hamilton::Types::MessageOrigin | Nil

  # True, if the message is sent to a forum topic.
  property is_topic_message : Bool | Nil

  # True, if the message is a channel post that was automatically forwarded to the connected discussion group.
  property is_automatic_forward : Bool | Nil

  # For replies in the same chat and message thread, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
  property reply_to_message : Hamilton::Types::Message | Nil

  # Information about the message that is being replied to, which may come from another chat or forum topic.
  property external_reply : Hamilton::Types::ExternalReplyInfo | Nil

  # For replies that quote part of the original message, the quoted part of the message.
  property quote : Hamilton::Types::TextQuote | Nil

  # For replies to a story, the original story.
  property reply_to_story : Hamilton::Types::Story | Nil

  # Identifier of the specific checklist task that is being replied to.
  property reply_to_checklist_task_id : Int32 | Nil
  
  # Bot through which the message was sent.
  property via_bot : Hamilton::Types::User | Nil
  
  # Date the message was last edited in Unix time.
  property edit_date : Int32 | Nil

  # True, if the message can't be forwarded.
  property has_protected_content : Bool | Nil

  # True, if the message was sent by an implicit action, for example, as an away or a greeting business message, or as a scheduled message.
  property is_from_offline : Bool | Nil

  # True, if the message is a paid post. Note that such posts must not be deleted for 24 hours to receive the payment and can't be edited.
  property is_paid_post : Bool | Nil

  # The unique identifier of a media message group this message belongs to.
  property media_group_id : String | Nil

  # Signature of the post author for messages in channels, or the custom title of an anonymous group administrator.
  property author_signature : String | Nil

  # The number of Telegram Stars that were paid by the sender of the message to send it.
  property paid_star_count : Int32 | Nil

  # For text messages, the actual UTF-8 text of the message.
  property text : String | Nil

  # For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Options used for link preview generation for the message, if it is a text message and link preview options were changed.
  property link_preview_options : Hamilton::Types::LinkPreviewOptions | Nil

  # Information about suggested post parameters if the message is a suggested post in a channel direct messages chat. If the message is an approved or declined suggested post, then it can't be edited.
  property suggested_post_info : Hamilton::Types::SuggestedPostInfo | Nil

  # Unique identifier of the message effect added to the message.
  property effect_id : String | Nil

  # Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set.
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

  # Caption for the animation, audio, document, paid media, photo, video or voice.
  property caption : String | Nil

  # For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption.
  property caption_entities : Array(MessageEntity) | Nil

  # True, if the caption must be shown above the message media.
  property show_caption_above_media	: Bool | Nil

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

  # Message is a native poll, information about the poll.
  property poll : Hamilton::Types::Poll | Nil

  # Message is a venue, information about the venue. For backward compatibility, when this field is set, the location field will also be set.
  property venue : Hamilton::Types::Venue | Nil

  # Message is a shared location, information about the location.
  property location : Hamilton::Types::Location | Nil

  # New members that were added to the group or supergroup and information about them (the bot itself may be one of these members).
  property new_chat_members : Array(Hamilton::Types::User) | Nil

  # A member was removed from the group, information about them (this member may be the bot itself).
  property left_chat_member : Hamilton::Types::User | Nil

  # A chat title was changed to this value.
  property new_chat_title : String | Nil

  # A chat photo was change to this value.
  property new_chat_photo : Array(Hamilton::Types::PhotoSize) | Nil

  # Service message: the chat photo was deleted.
  property delete_chat_photo : Bool | Nil

  # Service message: the group has been created.
  property group_chat_created : Bool | Nil

  # Service message: the supergroup has been created. This field can't be received in a message coming through updates, because bot can't be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
  property supergroup_chat_created : Bool | Nil

  # Service message: the channel has been created. This field can't be received in a message coming through updates, because bot can't be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
  property channel_chat_created	: Bool | Nil

  # Service message: auto-delete timer settings changed in the chat.
  property message_auto_delete_timer_changed : Hamilton::Types::MessageAutoDeleteTimerChanged | Nil

  # The group has been migrated to a supergroup with the specified identifier.
  property migrate_to_chat_id : Int64 | Nil

  # The supergroup has been migrated from a group with the specified identifier.
  property migrate_from_chat_id	 : Int64 | Nil

  # Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
  property pinned_message : Hamilton::Types::MaybeInaccessibleMessage | Nil

  # Message is an invoice for a payment, information about the invoice.
  property invoice : Hamilton::Types::Invoice | Nil

  # Message is a service message about a successful payment, information about the payment.
  property successful_payment : Hamilton::Types::SuccessfulPayment | Nil

  # Message is a service message about a refunded payment, information about the payment.
  property refunded_payment : Hamilton::Types::RefundedPayment | Nil

  # Service message: users were shared with the bot.
  property users_shared : Hamilton::Types::UsersShared | Nil

  # Service message: a chat was shared with the bot.
  property chat_shared : Hamilton::Types::ChatShared | Nil

  # Service message: a regular gift was sent or received.
  property gift : Hamilton::Types::GiftInfo | Nil

  # Service message: a unique gift was sent or received.
  property unique_gift : Hamilton::Types::UniqueGiftInfo | Nil

  # Service message: the user allowed the bot to write messages after adding it to the attachment or side menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess.
  property write_access_allowed	: Hamilton::Types::WriteAccessAllowed | Nil

  # Telegram Passport data.
  property passport_data : Hamilton::Types::PassportData | Nil

  # Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.
  property proximity_alert_triggered : Hamilton::Types::ProximityAlertTriggered | Nil

  # Service message: user boosted the chat.
  property boost_added : Hamilton::Types::ChatBoostAdded | Nil

  # Service message: chat background set.
  property chat_background_set : Hamilton::Types::ChatBackground | Nil

  # Service message: some tasks in a checklist were marked as done or not done.
  property checklist_tasks_done	: Hamilton::Types::ChecklistTasksDone | Nil

  # Service message: tasks were added to a checklist.
  property checklist_tasks_added : Hamilton::Types::ChecklistTasksAdded | Nil

  # Service message: the price for paid messages in the corresponding direct messages chat of a channel has changed.
  property direct_message_price_changed : Hamilton::Types::DirectMessagePriceChanged | Nil

  # Service message: forum topic created.
  property forum_topic_created : Hamilton::Types::ForumTopicCreated | Nil

  # Service message: forum topic edited.
  property forum_topic_edited : Hamilton::Types::ForumTopicEdited | Nil

  # Service message: forum topic closed.
  property forum_topic_closed : Hamilton::Types::ForumTopicClosed | Nil

  # Service message: forum topic reopened.
  property forum_topic_reopened	: Hamilton::Types::ForumTopicReopened | Nil

  # Service message: the 'General' forum topic hidden.
  property general_forum_topic_hidden : Hamilton::Types::GeneralForumTopicHidden | Nil

  # Service message: the 'General' forum topic unhidden.
  property general_forum_topic_unhidden	: Hamilton::Types::GeneralForumTopicUnhidden | Nil

  # Service message: a scheduled giveaway was created.
  property giveaway_created : Hamilton::Types::GiveawayCreated | Nil

  # The message is a scheduled giveaway message.
  property giveaway	: Hamilton::Types::Giveaway | Nil

  # A giveaway with public winners was completed.
  property giveaway_winners : Hamilton::Types::GiveawayWinners | Nil

  # Service message: a giveaway without public winners was completed.
  property giveaway_completed : Hamilton::Types::GiveawayCompleted | Nil

  # Service message: the price for paid messages has changed in the chat.
  property paid_message_price_changed : Hamilton::Types::PaidMessagePriceChanged | Nil

  # Service message: a suggested post was approved.
  property suggested_post_approved : Hamilton::Types::SuggestedPostApproved | Nil

  # Service message: approval of a suggested post has failed.
  property suggested_post_approval_failed : Hamilton::Types::SuggestedPostApprovalFailed | Nil

  # Service message: a suggested post was declined.
  property suggested_post_declined : Hamilton::Types::SuggestedPostDeclined | Nil

  # Service message: payment for a suggested post was received.
  property suggested_post_paid : Hamilton::Types::SuggestedPostPaid | Nil

  # Service message: payment for a suggested post was refunded.
  property suggested_post_refunded : Hamilton::Types::SuggestedPostRefunded | Nil

  # Service message: video chat scheduled.
  property video_chat_scheduled : Hamilton::Types::VideoChatScheduled | Nil

  # Service message: video chat started.
  property video_chat_started : Hamilton::Types::VideoChatStarted | Nil

  # Service message: video chat ended.
  property video_chat_ended : Hamilton::Types::VideoChatEnded | Nil

  # Service message: new participants invited to a video chat.
  property video_chat_participants_invited : Hamilton::Types::VideoChatParticipantsInvited | Nil

  # Service message: data sent by a Web App.
  property web_app_data : Hamilton::Types::WebAppData | Nil

  # Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil
end