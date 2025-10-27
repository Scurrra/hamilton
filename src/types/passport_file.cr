require "json"
require "./utils.cr"

# This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don't exceed 10MB.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportFile
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # File size in bytes.
  property file_size : Int32

  # Unix time when the file was uploaded.
  property file_date : Int32
end