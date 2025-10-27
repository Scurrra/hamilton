require "json"
require "./utils.cr"

# This object represents a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Chat
  include JSON::Serializable
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
end