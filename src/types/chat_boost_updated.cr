require "json"

# This object represents a boost added to a chat or changed.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostUpdated
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

  # Chat which was boosted.
  property chat : Hamilton::Types::Chat

  # Information about the chat boost.
  property boost : Hamilton::Types::ChatBoost
end