require "json"
require "./utils.cr"

# Describes the paid media added to a message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaInfo
  include JSON::Serializable
  include Hamilton::Types::Common

  # The number of Telegram Stars that must be paid to buy access to the media.
  property star_count : Int32

  # Information about the paid media.
  property paid_media : Array(Hamilton::Types::PaidMedia)
end