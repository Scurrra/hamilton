require "json"
require "./utils.cr"

# The paid media isn't available before the payment..
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaPreview
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the paid media, always “preview”.
  property type : String

  # Media width as defined by the sender.
  property width : Int32 | Nil

  # Media height as defined by the sender.
  property height : Int32 | Nil

  # Duration of the media in seconds as defined by the sender.
  property duration : Int32 | Nil
end

# The paid media is a photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaPhoto
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the paid media, always "photo".
  property type : String

  # The photo.
  property photo : Array(Hamilton::Types::PhotoSize)
end

# The paid media is a video.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaVideo
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the paid media, always "video".
  property type : String

  # The video.
  property video : Hamilton::Types::Video
end

# This object describes paid media.
alias Hamilton::Types::PaidMedia = Hamilton::Types::PaidMediaPreview | Hamilton::Types::PaidMediaPhoto | Hamilton::Types::PaidMediaVideo