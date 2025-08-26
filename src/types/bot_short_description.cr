require "json"

# This object represents the bot's short description.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BotShortDescription
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

  # The bot's short description.
  property short_description : String
end