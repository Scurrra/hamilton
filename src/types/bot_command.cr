require "json"

# This object represents a bot command.
#
# The following algorithm is used to determine the list of commands for a particular user viewing the bot menu. The first list of commands which is set is returned:
# Commands in the chat with the bot:
# - botCommandScopeChat + language_code
# - botCommandScopeChat
# - botCommandScopeAllPrivateChats + language_code
# - botCommandScopeAllPrivateChats
# - botCommandScopeDefault + language_code
# - botCommandScopeDefault
# 
# Commands in group and supergroup chats:
# - botCommandScopeChatMember + language_code
# - botCommandScopeChatMember
# - botCommandScopeChatAdministrators + language_code (administrators only)
# - botCommandScopeChatAdministrators (administrators only)
# - botCommandScopeChat + language_code
# - botCommandScopeChat
# - botCommandScopeAllChatAdministrators + language_code (administrators only)
# - botCommandScopeAllChatAdministrators (administrators only)
# - botCommandScopeAllGroupChats + language_code
# - botCommandScopeAllGroupChats
# - botCommandScopeDefault + language_code
# - botCommandScopeDefault
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommand
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

  # Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores.
  property command : String

  # Description of the command; 1-256 characters.
  property description : String
end