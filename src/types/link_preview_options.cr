require "json"
require "./utils.cr"

# Describes the options used for link preview generation.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::LinkPreviewOptions
  include Hamilton::Types::Common

  # True, if the link preview is disabled.
  property is_disabled : Bool | Nil

  # URL to use for the link preview. If empty, then the first URL found in the message text will be used.
  property url : String | Nil

  # True, if the media in the link preview is supposed to be shrunk; ignored if the URL isn't explicitly specified or media size change isn't supported for the preview.
  property prefer_small_media : Bool | Nil

  # True, if the media in the link preview is supposed to be enlarged; ignored if the URL isn't explicitly specified or media size change isn't supported for the preview.
  property prefer_large_media : Bool | Nil

  # True, if the link preview must be shown above the message text; otherwise, the link preview will be shown below the message text.
  property show_above_text : Bool | Nil
end