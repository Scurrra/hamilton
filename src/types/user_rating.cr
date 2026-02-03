require "json"
require "./utils.cr"

# This object describes the rating of a user based on their Telegram Star spendings.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserRating
  include JSON::Serializable
  include Hamilton::Types::Common

  # Current level of the user, indicating their reliability when purchasing digital goods and services. A higher level suggests a more trustworthy customer; a negative level is likely reason for concern.
  property level : Int32

  # Numerical value of the user's rating; the higher the rating, the better.
  property rating : Int32

  # The rating value required to get the current level.
  property current_level_rating : Int32

  # The rating value required to get to the next level; omitted if the maximum level was reached.
  property next_level_rating : Int32 | Nil
end
