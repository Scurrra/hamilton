require "json"
require "./utils.cr"

# Describes the birthdate of a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Birthdate
  include JSON::Serializable
  include Hamilton::Types::Common

  # Day of the user's birth; 1-31.
  property day : Int32

  # Month of the user's birth; 1-12.
  property month : Int32

  # Year of the user's birth.
  property year : Int32 | Nil
end