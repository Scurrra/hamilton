require "json"
require "./utils.cr"

# At most one of the optional fields can be present in any given object.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollMedia
  include JSON::Serializable
  include Hamilton::Types::Common

  # Media is an animation, information about the animation.
  property animation : Hamilton::Types::Animation | Nil

  # Media is an audio file, information about the file; currently, can't be received in a poll option.
  property audio : Hamilton::Types::Audio | Nil

  # Media is a general file, information about the file; currently, can't be received in a poll option.
  property document : Hamilton::Types::Document | Nil

  # Media is a shared location, information about the location.
  property location : Hamilton::Types::Location | Nil

  # Media is a photo, available sizes of the photo.
  property photo : Array(Hamilton::Types::PhotoSize) | Nil

  # Media is a sticker, information about the sticker; currently, for poll options only.
  property sticker : Hamilton::Types::Sticker | Nil

  # Media is a venue, information about the venue.
  property venue : Hamilton::Types::Venue | Nil

  # Media is a video, information about the video.
  property video : Hamilton::Types::Video | Nil

  # The bot's name.
  property name : String
end
