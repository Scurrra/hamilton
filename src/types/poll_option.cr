require "json"

# This object contains information about one answer option in a poll.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PollOption
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

  # Option text, 1-100 characters.
  property text : String

  # Special entities that appear in the option text. Currently, only custom emoji entities are allowed in poll option texts
  property text_entities : Array(Hamilton::Types::MessageEntity) | Nil
  
  # Number of users that voted for this option.
  property voter_count : Int32
end