require "json"

# Describes an inline message sent by a Web App on behalf of a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SentWebAppMessage
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

  # Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message.
  property inline_message_id : String | Nil
end