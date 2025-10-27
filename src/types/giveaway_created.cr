require "json"
require "./utils.cr"

# This object represents a service message about the creation of a scheduled giveaway.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiveawayCreated
  include JSON::Serializable
  include Hamilton::Types::Common

  # The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only.
  property prize_star_count : Int32 | Nil
end