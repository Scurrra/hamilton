require "json"
require "./utils.cr"

# Describes a service message about an ownership change in the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatOwnerChanged
  include JSON::Serializable
  include Hamilton::Types::Common

  # The new owner of the chat.
  property new_owner : Hamilton::Types::User
end
