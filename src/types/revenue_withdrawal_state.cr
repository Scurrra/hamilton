require "json"
require "./utils.cr"

# The withdrawal is in progress.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::RevenueWithdrawalStatePending
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the state, always “pending”.
  property type : String
end

# The withdrawal succeeded.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::RevenueWithdrawalStateSucceeded
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the state, always "succeeded".
  property type : String

  # Date the withdrawal was completed in Unix time.
  property date : Int32

  # An HTTPS URL that can be used to see transaction details.
  property url : String
end

# The withdrawal failed and the transaction was refunded.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::RevenueWithdrawalStateFailed
  include JSON::Serializable
  include Hamilton::Types::Common

  # Type of the state, always "failed".
  property type : String
end

# This object describes the state of a revenue withdrawal operation.
alias Hamilton::Types::RevenueWithdrawalState = Hamilton::Types::RevenueWithdrawalStatePending | Hamilton::Types::RevenueWithdrawalStateSucceeded | Hamilton::Types::RevenueWithdrawalStateFailed