require "json"

# This object represents a list of boosts added to a chat by a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserChatBoosts
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

  # The list of boosts added to the chat by the user.
  property boosts : Array(Hamilton::Types::ChatBoost)
end