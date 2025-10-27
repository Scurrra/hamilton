require "json"
require "./utils.cr"

# Describes documents or other Telegram Passport elements shared with the bot by the user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::EncryptedPassportElement
  include JSON::Serializable
  include Hamilton::Types::Common

  # Element type. One of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”, “phone_number”, “email”.
  property type : String

  # Base64-encoded encrypted Telegram Passport element data provided by the user; available only for “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport” and “address” types. Can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property data : String | Nil

  # User's verified phone number; available only for “phone_number” type.
  property phone_number : String | Nil

  # User's verified email address; available only for “email” type.
  property email : String | Nil

  # Array of encrypted files with documents provided by the user; available only for “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property files : Array(Hamilton::Types::PassportFile) | Nil

  # Encrypted file with the front side of the document, provided by the user; available only for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property front_side : Hamilton::Types::PassportFile | Nil

  # Encrypted file with the reverse side of the document, provided by the user; available only for “driver_license” and “identity_card”. The file can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property reverse_side : Hamilton::Types::PassportFile | Nil

  # Encrypted file with the selfie of the user holding a document, provided by the user; available if requested for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property selfie : Hamilton::Types::PassportFile | Nil

  # Array of encrypted files with translated versions of documents provided by the user; available if requested for “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying `EncryptedCredentials`.
  property translation : Array(Hamilton::Types::PassportFile) | Nil

  # Base64-encoded element hash for using in `PassportElementErrorUnspecified`.
  property hash : String
end