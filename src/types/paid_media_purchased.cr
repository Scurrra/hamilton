require "json"
require "./utils.cr"

# This object contains information about a paid media purchase.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaPurchased
  include Hamilton::Types::Common

  # User who purchased the media.
  property from : Hamilton::Types::User

  # Bot-specified paid media payload.
  property paid_media_payload : Int32
end