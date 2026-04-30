require "json"
require "./utils.cr"

# Describes a service message about the chat owner leaving the chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatOwnerLeft
  include JSON::Serializable
  include Hamilton::Types::Common

  # The user which will be the new owner of the chat if the previous owner does not return to the chat.
  property new_owner : Hamilton::Types::User | Nil
end
