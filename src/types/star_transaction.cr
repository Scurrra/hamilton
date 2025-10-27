require "json"
require "./utils.cr"

# Describes a Telegram Star transaction. Note that if the buyer initiates a chargeback with the payment provider from whom they acquired Stars (e.g., Apple, Google) following this transaction, the refunded Stars will be deducted from the bot's balance. This is outside of Telegram's control.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StarTransaction
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the transaction. Coincides with the identifier of the original transaction for refund transactions. Coincides with `SuccessfulPayment.telegram_payment_charge_id` for successful incoming payments from users.
  property id : String

  # Integer amount of Telegram Stars transferred by the transaction.
  property amount : Int32

  # The number of 1/1000000000 shares of Telegram Stars transferred by the transaction; from 0 to 999999999.
  property nanostar_amount : Int32 | Nil

  # Date the transaction was created in Unix time.
  property date : Int32

  # Source of an incoming transaction (e.g., a user purchasing goods or services, Fragment refunding a failed withdrawal). Only for incoming transactions.
  property source : Hamilton::Types::TransactionPartner | Nil

  # Receiver of an outgoing transaction (e.g., a user for a purchase refund, Fragment for a withdrawal). Only for outgoing transactions.
  property receiver : Hamilton::Types::TransactionPartner | Nil
end

# Contains a list of Telegram Star transactions.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StarTransactions
  include JSON::Serializable
  include Hamilton::Types::Common
  
  # The list of transactions.
  property transactions : Array(Hamilton::Types::StarTransaction)
end