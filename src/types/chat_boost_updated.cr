require "json"
require "./utils.cr"

# This object represents a boost added to a chat or changed.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostUpdated
  include JSON::Serializable
  include Hamilton::Types::Common

  # Chat which was boosted.
  property chat : Hamilton::Types::Chat

  # Information about the chat boost.
  property boost : Hamilton::Types::ChatBoost
end