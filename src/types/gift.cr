require "json"
require "./utils.cr"

# This object represents a gift that can be sent by the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Gift
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the gift.
  property id : String

  # The sticker that represents the gift.
  property sticker : Hamilton::Types::Sticker

  # The number of Telegram Stars that must be paid to send the sticker.
  property star_count : Int32

  # The number of Telegram Stars that must be paid to upgrade the gift to a unique one.
  property upgrade_star_count : Int32 | Nil

  # True, if the gift can only be purchased by Telegram Premium subscribers.
  property is_premium : Bool | Nil

  # True, if the gift can be used (after being upgraded) to customize a user's appearance.
  property has_colors : Bool | Nil

  # The total number of the gifts of this type that can be sent; for limited gifts only.
  property total_count : Int32 | Nil

  # The number of remaining gifts of this type that can be sent; for limited gifts only.
  property remaining_count : Int32 | Nil

  # The total number of gifts of this type that can be sent by the bot; for limited gifts only.
  property personal_total_count : Int32 | Nil

  # The number of remaining gifts of this type that can be sent by the bot; for limited gifts only.
  property personal_remaining_count : Int32 | Nil

  # Background of the gift.
  property background : Hamilton::Types::GiftBackground | Nil

  # The total number of different unique gifts that can be obtained by upgrading the gift.
  property unique_gift_variant_count : Int32 | Nil

  # Information about the chat that published the gift.
  property publisher_chat : Hamilton::Types::Chat | Nil
end

# This object represent a list of gifts.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Gifts
  include JSON::Serializable
  include Hamilton::Types::Common

  # The list of gifts.
  property gifts : Array(Hamilton::Types::Gift)
end
