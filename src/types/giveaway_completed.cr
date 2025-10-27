require "json"
require "./utils.cr"

# This object represents a service message about the completion of a giveaway without public winners.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiveawayCompleted
  include JSON::Serializable
  include Hamilton::Types::Common

  # Number of winners in the giveaway.
  property winner_count : Int32

  # Number of undistributed prizes.
  property unclaimed_prize_count : Int32 | Nil

  # Message with the giveaway that was completed, if it wasn't deleted.
  property giveaway_message : Hamilton::Types::Message | Nil

  # True, if the giveaway is a Telegram Star giveaway. Otherwise, currently, the giveaway is a Telegram Premium giveaway.
  property is_star_giveaway : Bool | Nil
end