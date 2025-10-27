require "json"
require "./utils.cr"

# A static profile photo in the .JPG format.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputProfilePhotoStatic
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the profile photo, must be "static".
  property type : String = "static"

  # The static profile photo. Profile photos can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the photo was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property photo : String
end

# An animated profile photo in the MPEG4 format.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputProfilePhotoAnimated
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the profile photo, must be "animated".
  property type : String = "animated"

  # The animated profile photo. Profile photos can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the photo was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property animation : String

  # Timestamp in seconds of the frame that will be used as the static profile photo. Defaults to 0.0.
  property main_frame_timestamp : Float32 | Nil
end

# This object describes a profile photo to set.
alias Hamilton::Types::InputProfilePhoto = Hamilton::Types::InputProfilePhotoStatic | Hamilton::Types::InputProfilePhotoAnimated