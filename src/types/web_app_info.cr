require "json"
require "./utils.cr"

# Describes a Web App.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::WebAppInfo
  include JSON::Serializable
  include Hamilton::Types::Common

  # An HTTPS URL of a Web App to be opened with additional data as specified in [Initializing Web Apps](https://core.telegram.org/bots/webapps#initializing-mini-apps).
  property url : String
end