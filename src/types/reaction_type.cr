require "json"
require "./utils.cr"

# The reaction is based on an emoji.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReactionTypeEmoji
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the reaction, always “emoji”.
  property type : String

  # Reaction emoji. Currently, it can be one of "❤", "👍", "👎", "🔥", "🥰", "👏", "😁", "🤔", "🤯", "😱", "🤬", "😢", "🎉", "🤩", "🤮", "💩", "🙏", "👌", "🕊", "🤡", "🥱", "🥴", "😍", "🐳", "❤‍🔥", "🌚", "🌭", "💯", "🤣", "⚡", "🍌", "🏆", "💔", "🤨", "😐", "🍓", "🍾", "💋", "🖕", "😈", "😴", "😭", "🤓", "👻", "👨‍💻", "👀", "🎃", "🙈", "😇", "😨", "🤝", "✍", "🤗", "🫡", "🎅", "🎄", "☃", "💅", "🤪", "🗿", "🆒", "💘", "🙉", "🦄", "😘", "💊", "🙊", "😎", "👾", "🤷‍♂", "🤷", "🤷‍♀", "😡".
  property emoji : String
end

# The reaction is based on a custom emoji.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReactionTypeCustomEmoji
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the reaction, always "custom_emoji".
  property type : String

  # Custom emoji identifier.
  property custom_emoji_id : String
end

# The reaction is paid.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReactionTypePaid
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the reaction, always "paid".
  property type : String
end

# This object describes the type of a reaction.
alias Hamilton::Types::ReactionType = Hamilton::Types::ReactionTypeEmoji | Hamilton::Types::ReactionTypeCustomEmoji | Hamilton::Types::ReactionTypePaid