require "json"
require "./utils.cr"

# This object represents the contents of a file to be uploaded. Must be posted using `multipart/form-data` in the usual way that files are uploaded via the browser.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputFile
  include Hamilton::Types::Common

  # File to be sent.
  @[JSON::Field(ignore: true)]
  property file : File

  # Filename.
  @[JSON::Field(ignore: true)]
  property filename : File
end
