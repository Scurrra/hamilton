require "json"
require "./utils.cr"

# This object represents one size of a photo or a file / sticker thumbnail.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PhotoSize
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Photo width.
  property width : Int32

  # Photo height.
  property height : Int32

  # File size in bytes.
  property file_size : Int32
end