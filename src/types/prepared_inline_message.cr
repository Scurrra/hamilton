require "json"

# Describes an inline message to be sent by a user of a Mini App.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PreparedInlineMessage
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

  # Unique identifier of the prepared message.
  property id : String

  # Expiration date of the prepared message, in Unix time. Expired prepared messages can no longer be used.
  property expiration_date : Int32
end