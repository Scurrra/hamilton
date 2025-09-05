require "json"
require "./utils.cr"

# Represents an invite link for a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatInviteLink
  include Hamilton::Types::Common

  # The invite link. If the link was created by another chat administrator, then the second part of the link will be replaced with “…”.
  property invite_link : String

  # Creator of the link.
  property creator : Hamilton::Types::User

  # True, if users joining the chat via the link need to be approved by chat administrators.
  property creates_join_request : Bool

  # True, if the link is primary.
  property is_primary : Bool

  # True, if the link is revoked.
  property is_revoked : Bool

  # Invite link name.
  property name : String | Nil

  # Point in time (Unix timestamp) when the link will expire or has been expired.
  property expire_date : Int32 | Nil

  # The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999.
  property member_limit : Int32 | Nil

  # Number of pending join requests created using this link.
  property pending_join_request_count : Int32 | Nil

  # The number of seconds the subscription will be active for before the next payment.
  property subscription_period : Int32 | Nil

  # The amount of Telegram Stars a user must pay initially and after each subsequent subscription period to be a member of the chat using the link.
  property subscription_price : Int32 | Nil
end