require "json"
require "./utils.cr"

# This object contains information about a chat boost.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoost
  include Hamilton::Types::Common

  # Unique identifier of the boost.
  property boost_id : String

  # Point in time (Unix timestamp) when the chat was boosted.
  property add_date : Int32

  # Point in time (Unix timestamp) when the boost will automatically expire, unless the booster's Telegram Premium subscription is prolonged.
  property expiration_date : Int32

  # Source of the added boost.
  property source : Hamilton::Types::ChatBoostSource
end