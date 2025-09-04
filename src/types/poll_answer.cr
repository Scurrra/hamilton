require "json"

# This object represents an answer of a user in a non-anonymous poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollAnswer
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
  property poll_id : String

  # The chat that changed the answer to the poll, if the voter is anonymous.
  property voter_chat : Hamilton::Types::Chat | Nil

  # The user that changed the answer to the poll, if the voter isn't anonymous.
  property user : Hamilton::Types::User | Nil

  # 0-based identifiers of chosen answer options. May be empty if the vote was retracted.
  property option_ids : Array(Int32)
end