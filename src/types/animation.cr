require "json"
require "./utils.cr"

# This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Animation
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

  # Animation thumbnail as defined by the sender.
  property thumbnail : Hamilton::Types::PhotoSize | Nil

  # Original animation filename as defined by the sender.
  property file_name : String | Nil

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end