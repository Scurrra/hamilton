require "json"

# Describes a regular gift owned by a user or a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::OwnedGiftRegular
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

  # Type of the gift, always “regular”.
  property type : String

  # Information about the regular gift.
  property gift : Hamilton::Types::Gift

  # Unique identifier of the gift for the bot; for gifts received on behalf of business accounts only.
  property owned_gift_id : String | Nil

  # Sender of the gift if it is a known user.
  property sender_user : Hamilton::Types::User | Nil

  # Date the gift was sent in Unix time.
  property send_date : Int32

  # Text of the message that was added to the gift.
  property text : String | Nil

  # Special entities that appear in the text.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # True, if the sender and gift text are shown only to the gift receiver; otherwise, everyone will be able to see them.
  property is_private : Bool | Nil

  # True, if the gift is displayed on the account's profile page; for gifts received on behalf of business accounts only.
  property is_saved : Bool | Nil

  # True, if the gift can be upgraded to a unique gift; for gifts received on behalf of business accounts only.
  property can_be_upgraded : Bool | Nil

  # True, if the gift was refunded and isn't available anymore.
  property was_refunded : Bool | Nil

  # Number of Telegram Stars that can be claimed by the receiver instead of the gift; omitted if the gift cannot be converted to Telegram Stars.
  property convert_star_count : Int32 | Nil

  # Number of Telegram Stars that were paid by the sender for the ability to upgrade the gift.
  property prepaid_upgrade_star_count : Int32 | Nil
end

# Describes a unique gift received and owned by a user or a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::OwnedGiftUnique
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

  # Type of the gift, always "unique".
  property type : String

  # Information about the unique gift.
  property gift : Hamilton::Types::UniqueGift

  # Unique identifier of the received gift for the bot; for gifts received on behalf of business accounts only.
  property owned_gift_id : String | Nil

  # Sender of the gift if it is a known user.
  property sender_user : Hamilton::Types::User | Nil

  # Date the gift was sent in Unix time.
  property send_date : Int32

  # True, if the gift is displayed on the account's profile page; for gifts received on behalf of business accounts only.
  property is_saved : Bool | Nil

  # True, if the gift can be transferred to another owner; for gifts received on behalf of business accounts only.
  property can_be_transferred : Bool | Nil

  # Number of Telegram Stars that must be paid to transfer the gift; omitted if the bot cannot transfer the gift.
  property transfer_star_count : Int32 | Nil

  # Point in time (Unix timestamp) when the gift can be transferred. If it is in the past, then the gift can be transferred now.
  property next_transfer_date : Int32 | Nil
end

# This object describes a gift received and owned by a user or a chat.
alias Hamilton::Types::OwnedGift = Hamilton::Types::OwnedGiftRegular | Hamilton::Types::OwnedGiftUnique

# Contains the list of gifts received and owned by a user or a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::OwnedGifts
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

  # The total number of gifts owned by the user or the chat.
  property total_count : Int32

  # The list of gifts.
  property gifts : Array(Hamilton::Types::OwnedGift)

  # Offset for the next request. If empty, then there are no more results.
  property next_offset : String | Nil
end