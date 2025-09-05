require "json"
require "./utils.cr"

# This object represents an audio file to be treated as music by the Telegram clients.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Audio
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Duration of the audio in seconds as defined by the sender.
  property duration : Int32

  # Performer of the audio as defined by the sender or by audio tags.
  property performer : String | Nil

  # Title of the audio as defined by the sender or by audio tags.
  property title : String | Nil

  # Original filename as defined by the sender.
  property file_name : String | Nil

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil

  # Thumbnail of the album cover to which the music file belongs.
  property thumbnail : Hamilton::Types::PhotoSize | Nil
end