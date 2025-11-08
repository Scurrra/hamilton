require "json"
require "./utils.cr"

# This object represents the contents of a file to be uploaded. Must be posted using `multipart/form-data` in the usual way that files are uploaded via the browser.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputFile
  include JSON::Serializable
  include Hamilton::Types::Common

  # File to be sent.
  @[JSON::Field(ignore: true)]
  property file : Crystal::System::File

  # Filename.
  @[JSON::Field(ignore: true)]
  property filename : String
end
