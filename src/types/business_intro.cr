require "json"
require "./utils.cr"

# Contains information about the start page settings of a Telegram Business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessIntro
  include JSON::Serializable
  include Hamilton::Types::Common

  # Title text of the business intro.
  property title : String | Nil

  # Message text of the business intro.
  property message : String | Nil

  # Sticker of the business intro.
  property sticker : Hamilton::Types::Sticker
end