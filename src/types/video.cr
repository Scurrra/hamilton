require "json"
require "./utils.cr"

# This object represents a video file.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Video
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Video width as defined by the sender.
  property width : Int32

  # Video height as defined by the sender.
  property height : Int32

  # Duration of the video in seconds as defined by the sender.
  property duration : Int32

  # Video thumbnail.
  property thumbnail : Hamilton::Types::PhotoSize | Nil

  # Available sizes of the cover of the video in the message.
  property cover : Array(Hamilton::Types::PhotoSize) | Nil

  # Timestamp in seconds from which the video will play in the message.
  property start_timestamp : Int32 | Nil

  # Original filename as defined by the sender.
  property file_name : String | Nil

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end