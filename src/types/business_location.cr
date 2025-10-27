require "json"
require "./utils.cr"

# Contains information about the location of a Telegram Business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessLocation
  include JSON::Serializable
  include Hamilton::Types::Common

  # Address of the business.
  property address : String

  # Location of the business.
  property location : Hamilton::Types::Location | Nil
end