require "json"
require "./utils.cr"

# Describes data required for decrypting and authenticating EncryptedPassportElement.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::EncryptedCredentials
  include JSON::Serializable
  include Hamilton::Types::Common

  # Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for `EncryptedPassportElement` decryption and authentication.
  property data : String

  # Base64-encoded data hash for data authentication.
  property hash : String

  # Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption.
  property secret : String
end