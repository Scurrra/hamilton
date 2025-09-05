require "json"
require "./utils.cr"

# This object represents a boost removed from a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostRemoved
  include Hamilton::Types::Common

  # Chat which was boosted.
  property chat : Hamilton::Types::Chat

  # Unique identifier of the boost.
  property boost_id : String

  # Point in time (Unix timestamp) when the boost was removed.
  property remove_date : Int32

  # Source of the removed boost.
  property source : Hamilton::Types::ChatBoostSource
end