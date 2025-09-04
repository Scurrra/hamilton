require "json"

# Describes why a request was unsuccessful.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ResponseParameters
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

  # The group has been migrated to a supergroup with the specified identifier.
  property migrate_to_chat_id : Int64 | Nil

  # In case of exceeding flood control, the number of seconds left to wait before the request can be repeated.
  property retry_after : Int32
end