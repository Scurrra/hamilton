require "json"

# Represents a menu button, which opens the bot's list of commands.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MenuButtonCommands
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

  # Type of the button, must be "commands".
  property type : String
end

# Represents a menu button, which launches a Web App.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MenuButtonWebApp
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

  # Type of the button, must be "web_app".
  property type : String

  # Text on the button.
  property text : String

  # Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery. Alternatively, a `t.me` link to a Web App of the bot can be specified in the object instead of the Web App's URL, in which case the Web App will be opened as if the user pressed the link.
  property web_app : Hamilton::Types::WebAppInfo
end

# Describes that no specific value for the menu button was set.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MenuButtonDefault
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

  # Type of the button, must be "default".
  property type : String
end

# This object describes the bot's menu button in a private chat.
#
# If a menu button other than MenuButtonDefault is set for a private chat, then it is applied in the chat. Otherwise the default menu button is applied. By default, the menu button opens the list of bot commands.
alias Hamilton::Types::MenuButton = Hamilton::Types::MenuButtonCommands | Hamilton::Types::MenuButtonWebApp | Hamilton::Types::MenuButtonDefault