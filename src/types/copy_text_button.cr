require "json"
require "./utils.cr"

# This object represents an inline keyboard button that copies specified text to the clipboard.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::CopyTextButton
  include Hamilton::Types::Common

  # The text to be copied to the clipboard; 1-256 characters.
  property text : String
end