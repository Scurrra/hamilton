require "json"
require "./utils.cr"

# This object represents a phone contact.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Contact
  include Hamilton::Types::Common

  # Contact's phone number.
  property phone_number : String

  # Contact's first name.
  property first_name : String

  # Contact's last name.
  property last_name : String | Nil

  # Contact's user identifier in Telegram.
  property user_id : Int64 | Nil

  # Additional data about the contact in the form of a vCard.
  property vcard : String | Nil
end