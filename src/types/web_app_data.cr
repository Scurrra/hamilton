require "json"

# Describes data sent from a Web App to the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::WebAppData
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

  # The data. Be aware that a bad client can send arbitrary data in this field.
  property data : String

  # Text of the web_app keyboard button from which the Web App was opened. Be aware that a bad client can send arbitrary data in this field.
  property button_text : String
end