require "json"
require "./utils.cr"

# This object represent a user's profile pictures.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserProfilePhotos
  include Hamilton::Types::Common

  # Total number of profile pictures the target user has.
  property total_count : Int32

  # Requested profile pictures (in up to 4 sizes each).
  property photos : Array(Array(Hamilton::Types::PhotoSize))
end