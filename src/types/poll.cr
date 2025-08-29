require "json"

# This object contains information about a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Poll
  include JSON::Serializable

  # List of available non-nil fields.
  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  # :nodoc:
  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Unique poll identifier.
  property id : String

  # Poll question, 1-300 characters.
  property question : String

  # Special entities that appear in the question. Currently, only custom emoji entities are allowed in poll questions.
  property question_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # List of poll options.
  property options : Array(Hamilton::Types::PollOption)

  # Total number of users that voted in the poll.
  property total_voter_count : Int32

  # True, if the poll is closed.
  property is_closed : Bool

  # True, if the poll is anonymous.
  property is_anonymous : Bool

  # Poll type, currently can be “regular” or “quiz”.
  property type : String

  # True, if the poll allows multiple answers.
  property allows_multiple_answers : Bool

  # 0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.
  property correct_option_id : Int32 | Nil

  # Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters.
  property explanation : String | Nil

  # Special entities like usernames, URLs, bot commands, etc. that appear in the explanation.
  property explanation_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Amount of time in seconds the poll will be active after creation.
  property open_period : Int32

  # Point in time (Unix timestamp) when the poll will be automatically closed.
  property close_date : Int32
end