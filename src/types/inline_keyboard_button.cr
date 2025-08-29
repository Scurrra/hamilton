require "json"

# This object represents one button of an inline keyboard. Exactly one of the optional fields must be used to specify type of the button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineKeyboardButton
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

  # Label text on the button.
  property text : String

  # HTTP or `tg://` URL to be opened when the button is pressed. Links `tg://user?id=<user_id>` can be used to mention a user by their identifier without using a username, if this is allowed by their privacy settings.
  property url : String | Nil

  # Data to be sent in a callback query to the bot when the button is pressed, 1-64 bytes.
  property callback_data : String | Nil

  # Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method `answerWebAppQuery`. Available only in private chats between a user and the bot. Not supported for messages sent on behalf of a Telegram Business account.
  property web_app : Hamilton::Types::WebAppInfo | Nil

  # An HTTPS URL used to automatically authorize the user. Can be used as a replacement for the Telegram Login Widget.
  property login_url : Hamilton::Types::LoginUrl | Nil

  # If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot's username and the specified inline query in the input field. May be empty, in which case just the bot's username will be inserted. Not supported for messages sent in channel direct messages chats and on behalf of a Telegram Business account.
  property switch_inline_query : String | Nil

  # If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field. May be empty, in which case only the bot's username will be inserted.
  # This offers a quick way for the user to open your bot in inline mode in the same chat - good for selecting something from multiple options. Not supported in channels and for messages sent in channel direct messages chats and on behalf of a Telegram Business account.
  property switch_inline_query_current_chat : String | Nil

  # If set, pressing the button will prompt the user to select one of their chats of the specified type, open that chat and insert the bot's username and the specified inline query in the input field. Not supported for messages sent in channel direct messages chats and on behalf of a Telegram Business account.
  property switch_inline_query_chosen_chat : Hamilton::Types::SwitchInlineQueryChosenChat | Nil

  # Description of the button that copies the specified text to the clipboard.
  property copy_text : Hamilton::Types::CopyTextButton | Nil

  # Description of the game that will be launched when the user presses the button.
  #
  # NOTE: This type of button must always be the first button in the first row.
  property callback_game : Hamilton::Types::CallbackGame | Nil

  # Specify True, to send a Pay button. Substrings “⭐” and “XTR” in the buttons's text will be replaced with a Telegram Star icon.
  # 
  # NOTE: This type of button must always be the first button in the first row and can only be used in invoice messages.
  property pay : Bool | Nil
end