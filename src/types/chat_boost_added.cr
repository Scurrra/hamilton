require "json"

# This object represents a service message about a user boosting a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostAdded
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Number of boosts added by the user.
  property boost_count : Int32
end