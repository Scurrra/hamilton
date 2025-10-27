require "json"
require "./utils.cr"

# Describes a photo to post as a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputStoryContentPhoto
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the content, must be "photo".
  property type : String = "photo"

  # The photo to post as a story. The photo must be of the size 1080x1920 and must not exceed 10 MB. The photo can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the photo was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property photo : Hamilton::Types::InputFile | String
end

# Describes a video to post as a story.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputStoryContentVideo
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the content, must be "video".
  property type : String = "video"

  # The video to post as a story. The video must be of the size 720x1280, streamable, encoded with H.265 codec, with key frames added each second in the MPEG4 format, and must not exceed 30 MB. The video can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the video was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property video : Hamilton::Types::InputFile | String

  # Precise duration of the video in seconds; 0-60.
  property duration : Float32 | Nil

  # Timestamp in seconds of the frame that will be used as the static cover for the story. Defaults to 0.0.
  property cover_frame_timestamp : Float32 | Nil

  # Pass True if the video has no sound.
  property is_animation : Bool | Nil
end

# This object describes the content of a story to post.
alias Hamilton::Types::InputStoryContent = Hamilton::Types::InputStoryContentPhoto | Hamilton::Types::InputStoryContentVideo
