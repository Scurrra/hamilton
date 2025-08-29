require "json"

# Represents the default scope of bot commands. Default commands are used if no commands with a narrower scope are specified for the user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeDefault
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

  # Scope type, must be "default".
  property type : String = "default"
end

# Represents the scope of bot commands, covering all private chats.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeAllPrivateChats
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

  # Scope type, must be "all_private_chats".
  property type : String = "all_private_chats"
end

# Represents the scope of bot commands, covering all group and supergroup chats.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeAllGroupChats
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

  # Scope type, must be "all_group_chats".
  property type : String = "all_group_chats"
end

# Represents the scope of bot commands, covering all group and supergroup chat administrators.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeAllChatAdministrators
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

  # Scope type, must be "all_chat_administrators".
  property type : String = "all_chat_administrators"
end

# Represents the scope of bot commands, covering a specific chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeChat
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

  # Scope type, must be "chat".
  property type : String = "chat"

  # Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`). Channel direct messages chats and channel chats aren't supported.
  property chat_id : String | Int32
end

# Represents the scope of bot commands, covering all administrators of a specific group or supergroup chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeChatAdministrators
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

  # Scope type, must be "chat_administrators".
  property type : String = "chat_administrators"

  # Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`). Channel direct messages chats and channel chats aren't supported.
  property chat_id : String | Int32
end

# Represents the scope of bot commands, covering a specific member of a group or supergroup chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotCommandScopeChatMember
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

  # Scope type, must be "default".
  property type : String = "default"

  # Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`). Channel direct messages chats and channel chats aren't supported.
  property chat_id : String | Int32

  # Unique identifier of the target user.
  property user_id : Int32
end

# This object represents the scope to which bot commands are applied.
alias Hamilton::Types::BotCommandScope = Hamilton::Types::BotCommandScopeDefault | Hamilton::Types::BotCommandScopeAllPrivateChats | Hamilton::Types::BotCommandScopeAllGroupChats | Hamilton::Types::BotCommandScopeAllChatAdministrators | Hamilton::Types::BotCommandScopeChat | Hamilton::Types::BotCommandScopeChatAdministrators | Hamilton::Types::BotCommandScopeChatMember