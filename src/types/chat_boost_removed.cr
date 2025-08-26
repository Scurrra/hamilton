require "json"

# This object represents a boost removed from a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatBoostRemoved
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

  # Unique identifier of the boost.
  property boost_id : String

  # Point in time (Unix timestamp) when the boost was removed.
  property remove_date : Int32

  # Source of the removed boost.
  property source : Hamilton::Types::ChatBoostSource
end