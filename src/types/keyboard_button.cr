require "json"
require "./utils.cr"

# This object represents one button of the reply keyboard. At most one of the fields other than text, `icon_custom_emoji_id`, and `style` must be used to specify the type of the button. For simple text buttons, String can be used instead of this object to specify the button text.
#
# NOTE: `request_users` and `request_chat` options will only work in Telegram versions released after 3 February, 2023. Older clients will display unsupported message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::KeyboardButton
  include JSON::Serializable
  include Hamilton::Types::Common

  # Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed.
  property text : String

  # Unique identifier of the custom emoji shown before the text of the button. Can only be used by bots that purchased additional usernames on Fragment or in the messages directly sent by the bot to private, group and supergroup chats if the owner of the bot has a Telegram Premium subscription.
  property icon_custom_emoji_id : String | Nil

  # Style of the button. Must be one of “danger” (red), “success” (green) or “primary” (blue). If omitted, then an app-specific style is used.
  property style : String | Nil

  # If specified, pressing the button will open a list of suitable users. Identifiers of selected users will be sent to the bot in a “users_shared” service message. Available in private chats only.
  property request_users : Hamilton::Types::KeyboardButtonRequestUsers | Nil

  # If specified, pressing the button will open a list of suitable chats. Tapping on a chat will send its identifier to the bot in a “chat_shared” service message. Available in private chats only.
  property request_chat : Hamilton::Types::KeyboardButtonRequestChat | Nil

  # If specified, pressing the button will ask the user to create and share a bot that will be managed by the current bot. Available for bots that enabled management of other bots in the `@BotFather` Mini App. Available in private chats only.
  property request_managed_bot : Hamilton::Types::KeyboardButtonRequestManagedBot | Nil

  # If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only.
  property request_contact : Bool | Nil

  # If True, the user's current location will be sent when the button is pressed. Available in private chats only.
  property request_location : Bool | Nil

  # If specified, the user will be asked to create a poll and send it to the bot when the button is pressed. Available in private chats only.
  property request_poll : Hamilton::Types::KeyboardButtonPollType | Nil

  # If specified, the described Web App will be launched when the button is pressed. The Web App will be able to send a “web_app_data” service message. Available in private chats only.
  property web_app : Hamilton::Types::WebAppInfo | Nil
end
