require "json"
require "./utils.cr"

# Describes a service message about a unique gift that was sent or received.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftInfo
  include Hamilton::Types::Common

  # Information about the gift.
  property gift : Hamilton::Types::UniqueGift

  # Origin of the gift. Currently, either “upgrade” for gifts upgraded from regular gifts, “transfer” for gifts transferred from other users or channels, or “resale” for gifts bought from other users.
  property origin : String

  # For gifts bought from other users, the price paid for the gift.
  property last_resale_star_count : Int32 | Nil

  # Unique identifier of the received gift for the bot; only present for gifts received on behalf of business accounts.
  property owned_gift_id : String | Nil

  # Number of Telegram Stars that must be paid to transfer the gift; omitted if the bot cannot transfer the gift.
  property transfer_star_count : Int32 | Nil

  # Point in time (Unix timestamp) when the gift can be transferred. If it is in the past, then the gift can be transferred now.
  property next_transfer_date : Int32 | Nil
end