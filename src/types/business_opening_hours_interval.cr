require "json"
require "./utils.cr"

# Describes an interval of time during which a business is open.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessOpeningHoursInterval
  include Hamilton::Types::Common

  # The minute's sequence number in a week, starting on Monday, marking the start of the time interval during which the business is open; 0 - 7 * 24 * 60.
  property opening_minute : Int32

  # The minute's sequence number in a week, starting on Monday, marking the end of the time interval during which the business is open; 0 - 8 * 24 * 60.
  property closing_minute : Int32
end