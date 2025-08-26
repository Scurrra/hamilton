require "json"

# This object represents a gift that can be sent by the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Gift
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

  # Unique identifier of the gift.
  property id : String

  # The sticker that represents the gift.
  property sticker : Hamilton::Types::Sticker

  # The number of Telegram Stars that must be paid to send the sticker.
  property star_count : Int32

  # The number of Telegram Stars that must be paid to upgrade the gift to a unique one.
  property upgrade_star_count : Int32 | Nil

  # The total number of the gifts of this type that can be sent; for limited gifts only.
  property total_count : Int32 | Nil

  # The number of remaining gifts of this type that can be sent; for limited gifts only.
  property remaining_count : Int32 | Nil

  # Information about the chat that published the gift.
  property publisher_chat : Hamilton::Types::Chat | Nil
end

# This object represent a list of gifts.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Gifts
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

  # The list of gifts.
  property gifts : Array(Hamilton::Types::Gift)
end