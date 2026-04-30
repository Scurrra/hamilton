require "json"
require "./utils.cr"

# This object contains information about one answer option in a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollOption
  include JSON::Serializable
  include Hamilton::Types::Common

  # Unique identifier of the option, persistent on option addition and deletion.
  property persistent_id : String

  # Option text, 1-100 characters.
  property text : String

  # Special entities that appear in the option text. Currently, only custom emoji entities are allowed in poll option texts
  property text_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Number of users that voted for this option.
  property voter_count : Int32

  # User who added the option; omitted if the option wasn't added by a user after poll creation.
  property added_by_user : Hamilton::Types::User | Nil

  # Chat that added the option; omitted if the option wasn't added by a chat after poll creation.
  property added_by_chat : Hamilton::Types::Chat | Nil

  # Point in time (Unix timestamp) when the option was added; omitted if the option existed in the original poll.
  property addition_date : Int32 | Nil
end
