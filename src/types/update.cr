require "json"
require "./utils.cr"

# This object represents an incoming update.
# At most one of the optional parameters can be present in any given update.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Update
  include Hamilton::Types::Common

  # The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially.
  property update_id : Int32

  # New incoming message of any kind - text, photo, sticker, etc.
  property message : Hamilton::Types::Message | Nil

  # New version of a message that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
  property edited_message : Hamilton::Types::Message | Nil

  # New incoming channel post of any kind - text, photo, sticker, etc.
  property channel_post : Hamilton::Types::Message | Nil

  # New version of a channel post that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
  property edited_channel_post : Hamilton::Types::Message | Nil

  # The bot was connected to or disconnected from a business account, or a user edited an existing connection with the bot.
  property business_connection : Hamilton::Types::BusinessConnection | Nil

  # New message from a connected business account.
  property business_message : Hamilton::Types::Message | Nil

  # New version of a message from a connected business account.
  property edited_business_message : Hamilton::Types::Message | Nil

  # Messages were deleted from a connected business account.
  property deleted_business_messages : Hamilton::Types::BusinessMessagesDeleted | Nil

  # A reaction to a message was changed by a user. The bot must be an administrator in the chat and must explicitly specify "message_reaction" in the list of allowed_updates to receive these updates. The update isn't received for reactions set by bots.
  property message_reaction : Hamilton::Types::MessageReactionUpdated | Nil

  # Reactions to a message with anonymous reactions were changed. The bot must be an administrator in the chat and must explicitly specify "message_reaction_count" in the list of allowed_updates to receive these updates. The updates are grouped and can be sent with delay up to a few minutes.
  property message_reaction_count : Hamilton::Types::MessageReactionCountUpdated | Nil

  # New incoming inline query.
  property inline_query : Hamilton::Types::InlineQuery | Nil

  # The result of an inline query that was chosen by a user and sent to their chat partner.
  property chosen_inline_result : Hamilton::Types::ChosenInlineResult | Nil

  # New incoming callback query.
  property callback_query : Hamilton::Types::CallbackQuery | Nil

  # New incoming shipping query. Only for invoices with flexible price.
  property shipping_query : Hamilton::Types::ShippingQuery | Nil

  # New incoming pre-checkout query. Contains full information about checkout.
  property pre_checkout_query : Hamilton::Types::PreCheckoutQuery | Nil

  # A user purchased paid media with a non-empty payload sent by the bot in a non-channel chat.
  property purchased_paid_media : Hamilton::Types::PaidMediaPurchased | Nil

  # New poll state. Bots receive only updates about manually stopped polls and polls, which are sent by the bot.
  property poll : Hamilton::Types::Poll | Nil

  # A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.
  property poll_answer : Hamilton::Types::PollAnswer | Nil

  # The bot's chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.
  property my_chat_member : Hamilton::Types::ChatMemberUpdated | Nil

  # A chat member's status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify "chat_member" in the list of allowed_updates to receive these updates.
  property chat_member : Hamilton::Types::ChatMemberUpdated | Nil

  # A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.
  property chat_join_request : Hamilton::Types::ChatJoinRequest | Nil

  # A chat boost was added or changed. The bot must be an administrator in the chat to receive these updates.
  property chat_boost : Hamilton::Types::ChatBoostUpdated | Nil

  # A boost was removed from a chat. The bot must be an administrator in the chat to receive these updates.
  property removed_chat_boost : Hamilton::Types::ChatBoostRemoved | Nil
end
