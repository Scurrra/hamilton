require "json"

# Represents a reaction added to a message along with the number of times it was added.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ReactionCount
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

  # Type of the reaction.
  property type : Hamilton::Types::ReactionType

  # Number of times the reaction was added.
  property total_count : Int32
end