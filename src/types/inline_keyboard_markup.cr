require "json"
require "./utils.cr"

# This object represents an inline keyboard that appears right next to the message it belongs to.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineKeyboardMarkup
  include JSON::Serializable
  include Hamilton::Types::Common

  # Array of button rows, each represented by an Array of InlineKeyboardButton objects.
  property inline_keyboard : Array(Array(Hamilton::Types::InlineKeyboardButton))
end