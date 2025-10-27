require "json"
require "./utils.cr"

# This object represents a service message about a user boosting a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostAdded
  include JSON::Serializable
  include Hamilton::Types::Common

  # Number of boosts added by the user.
  property boost_count : Int32
end