require "json"
require "./utils.cr"

# This object represents the audios displayed on a user's profile.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserProfileAudios
  include JSON::Serializable
  include Hamilton::Types::Common

  # Total number of profile audios for the target user.
  property total_count : Int32

  # List of profile audios.
  property audios : Array(Hamilton::Types::Audio) | Nil
end
