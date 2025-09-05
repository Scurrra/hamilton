require "json"
require "./utils.cr"

# Describes the price of a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostPrice
  include Hamilton::Types::Common

  # Currency in which the post will be paid. Currently, must be one of “XTR” for Telegram Stars or “TON” for toncoins.
  property currency : String

  # The amount of the currency that will be paid for the post in the smallest units of the currency, i.e. Telegram Stars or nanotoncoins. Currently, price in Telegram Stars must be between 5 and 100000, and price in nanotoncoins must be between 10000000 and 10000000000000.
  property amount : Int32
end