require "json"
require "./utils.cr"

# Describes the opening hours of a business.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessOpeningHours
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique name of the time zone for which the opening hours are defined.
  property time_zone_name : String

  # List of time intervals describing business opening hours.
  property opening_hours : Array(Hamilton::Types::BusinessOpeningHoursInterval)
end