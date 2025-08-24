require "json"

# This object represents a parameter of the inline keyboard button used to automatically authorize a user. Serves as a great replacement for the Telegram Login Widget when the user is coming from Telegram. All the user needs to do is tap/click a button and confirm that they want to log in. Telegram apps support these buttons as of version 5.7.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LoginUrl
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

  # An HTTPS URL to be opened with user authorization data added to the query string when the button is pressed. If the user refuses to provide authorization data, the original URL without information about the user will be opened. The data added is the same as described in Receiving authorization data.
  # 
  # NOTE: You must always check the hash of the received data to verify the authentication and the integrity of the data as described in Checking authorization.
  property url : String

  # New text of the button in forwarded messages.
  property forward_text : String | Nil

  # Username of a bot, which will be used for user authorization. See Setting up a bot for more details. If not specified, the current bot's username will be assumed. The url's domain must be the same as the domain linked with the bot. See Linking your domain to the bot for more details.
  property bot_username : String | Nil

  # Pass True to request the permission for your bot to send messages to the user.
  property request_write_access : Bool | Nil
end