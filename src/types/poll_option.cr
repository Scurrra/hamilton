require "json"
require "./utils.cr"

# This object contains information about one answer option in a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollOption
  include Hamilton::Types::Common

  # Option text, 1-100 characters.
  property text : String

  # Special entities that appear in the option text. Currently, only custom emoji entities are allowed in poll option texts
  property text_entities : Array(Hamilton::Types::MessageEntity) | Nil
  
  # Number of users that voted for this option.
  property voter_count : Int32
end