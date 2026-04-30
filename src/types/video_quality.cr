require "json"
require "./utils.cr"

# This object represents a video file of a specific quality.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoQuality
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Video width.
  property width : Int32

  # Video height.
  property height : Int32

  # Codec that was used to encode the video, for example, “h264”, “h265”, or “av01”.
  property codec : String

  # File size in bytes.
  property file_size : Int64 | Nil
end
