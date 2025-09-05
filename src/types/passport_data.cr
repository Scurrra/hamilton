require "json"
require "./utils.cr"

# Describes Telegram Passport data shared with the bot by the user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportData
  include Hamilton::Types::Common

  # Array with information about documents and other Telegram Passport elements that was shared with the bot.
  property data : Array(Hamilton::Types::EncryptedPassportElement)

  # Encrypted credentials required to decrypt the data.
  property credentials : Hamilton::Types::EncryptedCredentials
end