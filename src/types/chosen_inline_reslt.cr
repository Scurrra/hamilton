require "json"

# Represents a result of an inline query that was chosen by the user and sent to their chat partner.
#
# NOTE: It is necessary to enable inline feedback via @BotFather in order to receive these objects in updates.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChosenInlineResult
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

  # The unique identifier for the result that was chosen.
  property result_id : String

  # The user that chose the result.
  property from : Hamilton::Types::User

  # Sender location, only for bots that require user location.
  property location : Hamilton::Types::Location	| Nil

  # Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.
  property inline_message_id : String | Nil

  # The query that was used to obtain the result.
  property query : String
end