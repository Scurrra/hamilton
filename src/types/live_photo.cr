require "json"
require "./utils.cr"

# This object represents a live photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LivePhoto
  include JSON::Serializable
  include Hamilton::Types::Common

  # Available sizes of the corresponding static photo.
  property photo : Array(Hamilton::Types::PhotoSize) | Nil

  # Identifier for the video file which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for the video file which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Video width as defined by the sender.
  property width : Int32

  # Video height as defined by the sender.
  property height : Int32

  # Duration of the video in seconds as defined by the sender.
  property duration : Int32

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end
