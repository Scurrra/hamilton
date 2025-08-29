require "json"

# This object represents a message about the completion of a giveaway with public winners.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiveawayWinners
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

  # The chat that created the giveaway.
  property chat : Hamilton::Types::Chat

  # Identifier of the message with the giveaway in the chat.
  property giveaway_message_id : Int32

  # Point in time (Unix timestamp) when winners of the giveaway were selected.
  property winners_selection_date : Int32

  # Total number of winners in the giveaway.
  property winner_count : Int32

  # List of up to 100 winners of the giveaway.
  property winners : Array(Hamilton::Types::User)

  # The number of other chats the user had to join in order to be eligible for the giveaway.
  property additional_chat_count : Int32 | Nil

  # The number of Telegram Stars that were split between giveaway winners; for Telegram Star giveaways only.
  property prize_star_count : Int32 | Nil

  # The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only.
  property premium_subscription_month_count : Int32 | Nil

  # Number of undistributed prizes.
  property unclaimed_prize_count : Int32 | Nil

  # True, if only users who had joined the chats after the giveaway started were eligible to win.
  property only_new_members : Bool | Nil

  # True, if the giveaway was canceled because the payment for it was refunded.
  property was_refunded : Bool | Nil

  # Description of additional giveaway prize.
  property prize_description : String | Nil
end