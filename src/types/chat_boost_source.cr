require "json"

# The boost was obtained by subscribing to Telegram Premium or by gifting a Telegram Premium subscription to another user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostSourcePremium
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

  # Source of the boost, always “premium”.
  property source : String

  # User that boosted the chat.
  property user : Hamilton::Types::User
end

# The boost was obtained by the creation of Telegram Premium gift codes to boost a chat. Each such code boosts the chat 4 times for the duration of the corresponding Telegram Premium subscription.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostSourceGiftCode
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

  # Source of the boost, always "gift_code".
  property source : String

  # User for which the gift code was created.
  property user : Hamilton::Types::User
end

# The boost was obtained by the creation of a Telegram Premium or a Telegram Star giveaway. This boosts the chat 4 times for the duration of the corresponding Telegram Premium subscription for Telegram Premium giveaways and prize_star_count / 500 times for one year for Telegram Star giveaways.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostSourceGiveaway
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

  # Source of the boost, always "giveaway".
  property source : String

  # Identifier of a message in the chat with the giveaway; the message could have been deleted already. May be 0 if the message isn't sent yet.
  property giveaway_message_id : Int32

  # User that won the prize in the giveaway if any; for Telegram Premium giveaways only.
  property user : Hamilton::Types::User | Nil

  # The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only.
  property prize_star_count : Int32 | Nil

  # True, if the giveaway was completed, but there was no user to win the prize.
  property is_unclaimed : Bool | Nil
end

# This object describes the source of a chat boost.
alias Hamilton::Types::ChatBoostSource = Hamilton::Types::ChatBoostSourcePremium | Hamilton::Types::ChatBoostSourceGiftCode | Hamilton::Types::ChatBoostSourceGiveaway