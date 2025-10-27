require "json"
require "./utils.cr"

# Describes the current status of a webhook.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::WebhookInfo
  include JSON::Serializable
  include Hamilton::Types::Common

  # Webhook URL, may be empty if webhook is not set up.
  property url : String

  # True, if a custom certificate was provided for webhook certificate checks.
  property has_custom_certificate : Bool

  # Number of updates awaiting delivery.
  property pending_update_count : Int32

  # Currently used webhook IP address.
  property ip_address : String | Nil

  # Unix time for the most recent error that happened when trying to deliver an update via webhook.
  property last_error_date : Int32 | Nil

  # Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook.
  property last_error_message : String | Nil

  # Unix time of the most recent error that happened when trying to synchronize available updates with Telegram datacenters.
  property last_synchronization_error_date : Int32 | Nil

  # The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery.
  property max_connections : Int32 | Nil

  # A list of update types the bot is subscribed to. Defaults to all update types except `chat_member`.
  property allowed_updates : Array(String) | Nil
end