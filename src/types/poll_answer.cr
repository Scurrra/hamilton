require "json"
require "./utils.cr"

# This object represents an answer of a user in a non-anonymous poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollAnswer
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique poll identifier.
  property poll_id : String

  # The chat that changed the answer to the poll, if the voter is anonymous.
  property voter_chat : Hamilton::Types::Chat | Nil

  # The user that changed the answer to the poll, if the voter isn't anonymous.
  property user : Hamilton::Types::User | Nil

  # 0-based identifiers of chosen answer options. May be empty if the vote was retracted.
  property option_ids : Array(Int32)
end