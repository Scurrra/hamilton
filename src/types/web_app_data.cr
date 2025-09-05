require "json"
require "./utils.cr"

# Describes data sent from a Web App to the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::WebAppData
  include Hamilton::Types::Common

  # The data. Be aware that a bad client can send arbitrary data in this field.
  property data : String

  # Text of the web_app keyboard button from which the Web App was opened. Be aware that a bad client can send arbitrary data in this field.
  property button_text : String
end