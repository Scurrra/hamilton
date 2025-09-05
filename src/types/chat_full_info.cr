require "json"
require "./utils.cr"

# This object contains full information about a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatFullInfo
  include Hamilton::Types::Common

  # Unique identifier for this chat.
  property id : Int64

  # Type of the chat, can be either “private”, “group”, “supergroup” or “channel”.
  property type : String

  # Title, for supergroups, channels and group chats.
  property title : String | Nil

  # Username, for private chats, supergroups and channels if available.
  property username : String | Nil

  # First name of the other party in a private chat.
  property first_name : String | Nil

  # Last name of the other party in a private chat.
  property last_name : String | Nil

  # True, if the supergroup chat is a forum (has topics enabled).
  property is_forum : Bool | Nil

  # True, if the chat is the direct messages chat of a channel.
  property is_direct_messaegs : Bool | Nil

  # Identifier of the accent color for the chat name and backgrounds of the chat photo, reply header, and link preview.
  property accent_color_id : Int32

  # The maximum number of reactions that can be set on a message in the chat.
  property max_reaction_count : Int32

  # Chat photo.
  property photo : Hamilton::Types::ChatPhoto | Nil

  # If non-empty, the list of all active chat usernames; for private chats, supergroups and channels.
  property active_usernames : Array(String) | Nil

  # For private chats, the date of birth of the user.
  property birthdate : Hamilton::Types::Birthdate | Nil

  # For private chats with business accounts, the intro of the business.
  property business_intro : Hamilton::Types::BusinessIntro | Nil

  # For private chats with business accounts, the location of the business.
  property business_location : Hamilton::Types::BusinessLocation | Nil

  # For private chats with business accounts, the opening hours of the business.
  property business_opening_hours : Hamilton::Types::BusinessOpeningHours | Nil

  # For private chats, the personal channel of the user.
  property personal_chat : Hamilton::Types::Chat | Nil

  # Information about the corresponding channel chat; for direct messages chats only.
  property parent_chat : Hamilton::Types::Chat | Nil

  # List of available reactions allowed in the chat. If omitted, then all emoji reactions are allowed.
  property available_reactions : Array(Hamilton::Types::ReactionType) | Nil

  # Custom emoji identifier of the emoji chosen by the chat for the reply header and link preview background.
  property background_custom_emoji_id : String | Nil

  # Identifier of the accent color for the chat's profile background.
  property profile_accent_color_id : Int32 | Nil

  # Custom emoji identifier of the emoji chosen by the chat for its profile background.
  property profile_background_custom_emoji_id : String | Nil

  # Custom emoji identifier of the emoji status of the chat or the other party in a private chat.
  property emoji_status_custom_emoji_id : String | Nil

  # Expiration date of the emoji status of the chat or the other party in a private chat, in Unix time, if any.
  property emoji_status_expiration_date : Int32 | Nil

  # Bio of the other party in a private chat.
  property bio : String | Nil

  # True, if privacy settings of the other party in the private chat allows to use tg://user?id=<user_id> links only in chats with the user.
  property has_private_forwards : Bool | Nil

  # True, if the privacy settings of the other party restrict sending voice and video note messages in the private chat.
  property has_restricted_voice_and_video_messages : Bool | Nil

  # True, if users need to join the supergroup before they can send messages.
  property join_to_send_messages : Bool | Nil

  # True, if all users directly joining the supergroup without using an invite link need to be approved by supergroup administrators.
  property join_by_request : Bool | Nil

  # Description, for groups, supergroups and channel chats.
  property description : String | Nil

  # Primary invite link, for groups, supergroups and channel chats.
  property invite_link : String | Nil

  # The most recent pinned message (by sending date).
  property pinned_message : Hamilton::Types::Message | Nil

  # Default chat member permissions, for groups and supergroups.
  property permissions : Hamilton::Types::ChatPermissions | Nil

  # Information about types of gifts that are accepted by the chat or by the corresponding user for private chats.
  property accepted_gift_types : Hamilton::Types::AcceptedGiftTypes

  # True, if paid media messages can be sent or forwarded to the channel chat. The field is available only for channel chats.
  property can_send_paid_media : Bool | Nil

  # For supergroups, the minimum allowed delay between consecutive messages sent by each unprivileged user; in seconds.
  property slow_mode_delay : Int32 | Nil

  # For supergroups, the minimum number of boosts that a non-administrator user needs to add in order to ignore slow mode and chat permissions.
  property unrestrict_boost_count : Int32 | Nil

  # The time after which all messages sent to the chat will be automatically deleted; in seconds.
  property message_auto_delete_time : Int32 | Nil

  # True, if aggressive anti-spam checks are enabled in the supergroup. The field is only available to chat administrators.
  property has_aggressive_anti_spam_enabled : Bool | Nil

  # True, if non-administrators can only get the list of bots and administrators in the chat.
  property has_hidden_members : Bool | Nil

  # True, if messages from the chat can't be forwarded to other chats.
  property has_protected_content : Bool | Nil

  # True, if new chat members will have access to old messages; available only to chat administrators.
  property has_visible_history : Bool | Nil

  # For supergroups, name of the group sticker set.
  property sticker_set_name : String | Nil

  # True, if the bot can change the group sticker set.
  property can_set_sticker_set : Bool | Nil

  # For supergroups, the name of the group's custom emoji sticker set. Custom emoji from this set can be used by all users and bots in the group.
  property custom_emoji_sticker_set_name : String | Nil

  # Unique identifier for the linked chat, i.e. the discussion group identifier for a channel and vice versa; for supergroups and channel chats.
  property linked_chat_id : Int64 | Nil

  # For supergroups, the location to which the supergroup is connected.
  property location : Hamilton::Types::ChatLocation | Nil
end