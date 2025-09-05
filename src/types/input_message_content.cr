require "json"
require "./utils.cr"

# Represents the content of a text message to be sent as the result of an inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputTextMessageContent
  include Hamilton::Types::Common

  # Text of the message to be sent, 1-4096 characters.
  property message_text : String

  # Mode for parsing entities in the message text.
  property parse_mode : String | Nil

  # List of special entities that appear in message text, which can be specified instead of `parse_mode`.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Link preview generation options for the message.
  property link_preview_options : Hamilton::Types::LinkPreviewOptions | Nil
end

# Represents the content of a location message to be sent as the result of an inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputLocationMessageContent
  include Hamilton::Types::Common

  # Latitude of the location in degrees.
  property latitude : Float32

  # Longitude of the location in degrees.
  property longitude : Float32

  # The radius of uncertainty for the location, measured in meters; 0-1500.
  property horizontal_accuracy : Float32 | Nil

  # Period in seconds during which the location can be updated, should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.
  property live_period : Int32 | Nil

  # For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
  property heading : Int32 | Nil

  # For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
  property proximity_alert_radius : Int32 | Nil
end

# Represents the content of a venue message to be sent as the result of an inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputVenueMessageContent
  include Hamilton::Types::Common

  # Latitude of the venue in degrees.
  property latitude : Float32

  # Longitude of the venue in degrees.
  property longitude : Float32

  # Name of the venue.
  property title : String

  # Address of the venue.
  property address : String

  # Foursquare identifier of the venue, if known.
  property foursquare_id : String | Nil

  # Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
  property foursquare_type : String | Nil

  # Google Places identifier of the venue.
  property google_place_id : String | Nil

  # Google Places type of the venue.
  property google_place_type : String | Nil
end

# Represents the content of a contact message to be sent as the result of an inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputContactMessageContent
  include Hamilton::Types::Common

  # Contact's phone number.
  property phone_number : String

  # Contact's first name.
  property first_name : String

  # Contact's last name.
  property last_name : String | Nil

  # Additional data about the contact in the form of a vCard, 0-2048 bytes.
  property vcard : String | Nil
end

# Represents the content of an invoice message to be sent as the result of an inline query.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputInvoiceMessageContent
  include Hamilton::Types::Common

  # Product name, 1-32 characters.
  property title : String

  # Product description, 1-255 characters.
  property description : String

  # Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use it for your internal processes.
  property payload : String

  # Payment provider token, obtained via @BotFather. Pass an empty string for payments in Telegram Stars.
  property provider_token : String | Nil

  # Three-letter ISO 4217 currency code, see more on currencies. Pass “XTR” for payments in Telegram Stars.
  property currency	: String

  # Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.). Must contain exactly one item for payments in Telegram Stars.
  property prices : Array(Hamilton::Types::LabeledPrice)

  # The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of `US$ 1.45` pass `max_tip_amount = 145`.
  property max_tip_amount : Int32 | Nil

  # A JSON-serialized array of suggested amounts of tip in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.
  property suggested_tip_amounts : Array(Int32) | Nil

  # A JSON-serialized object for data about the invoice, which will be shared with the payment provider. A detailed description of the required fields should be provided by the payment provider.
  property provider_data : String | Nil

  # URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service.
  property photo_url : String | Nil

  # Photo size in bytes.
  property photo_size : Int32 | Nil

  # Photo width.
  property photo_width : Int32 | Nil

  # Photo height.
  property photo_height : Int32 | Nil

  # Pass True if you require the user's full name to complete the order. Ignored for payments in Telegram Stars.
  property need_name : Bool | Nil

  # Pass True if you require the user's phone number to complete the order. Ignored for payments in Telegram Stars.
  property need_phone_number : Bool | Nil

  # Pass True if you require the user's email address to complete the order. Ignored for payments in Telegram Stars.
  property need_email : Bool | Nil

  # Pass True if you require the user's shipping address to complete the order. Ignored for payments in Telegram Stars.
  property need_shipping_address : Bool | Nil

  # Pass True if the user's phone number should be sent to the provider. Ignored for payments in Telegram Stars.
  property send_phone_number_to_provider : Bool | Nil

  # Pass True if the user's email address should be sent to the provider. Ignored for payments in Telegram Stars.
  property send_email_to_provider : Bool | Nil

  # Pass True if the final price depends on the shipping method. Ignored for payments in Telegram Stars.
  property is_flexible : Bool | Nil
end

# This object represents the content of a message to be sent as a result of an inline query.
alias Hamilton::Types::InputMessageContent = Hamilton::Types::InputTextMessageContent | Hamilton::Types::InputLocationMessageContent | Hamilton::Types::InputVenueMessageContent | Hamilton::Types::InputContactMessageContent | Hamilton::Types::InputInvoiceMessageContent