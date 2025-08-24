require "json"

# This object contains information about the users whose identifiers were shared with the bot using a KeyboardButtonRequestUsers button.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UsersShared
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

  # Identifier of the request.
  property request_id : Int32

  # Information about users shared with the bot.
  property users : Array(Hamilton::Types::SharedUser)
end