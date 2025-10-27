require "json"
require "./utils.cr"

# Describes an inline message sent by a Web App on behalf of a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SentWebAppMessage
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message.
  property inline_message_id : String | Nil
end