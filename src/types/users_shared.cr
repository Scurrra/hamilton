require "json"
require "./utils.cr"

# This object contains information about the users whose identifiers were shared with the bot using a KeyboardButtonRequestUsers button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UsersShared
  include JSON::Serializable
  include Hamilton::Types::Common

  # Identifier of the request.
  property request_id : Int32

  # Information about users shared with the bot.
  property users : Array(Hamilton::Types::SharedUser)
end