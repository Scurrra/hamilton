require "json"
require "./utils.cr"

# Contains information about a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostInfo
  include Hamilton::Types::Common

  # State of the suggested post. Currently, it can be one of “pending”, “approved”, “declined”.
  property state : String

  # Proposed price of the post. If the field is omitted, then the post is unpaid.
  property price : Hamilton::Types::SuggestedPostPrice | Nil

  # Proposed send date of the post. If the field is omitted, then the post can be published at any time within 30 days at the sole discretion of the user or administrator who approves it.
  property send_date : Int32 | Nil
end