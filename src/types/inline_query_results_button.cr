require "json"

# This object represents a button to be shown above inline query results. You must use exactly one of the optional fields.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultsButton
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

  # Label text on the button.
  property text : String

  # Description of the Web App that will be launched when the user presses the button. The Web App will be able to switch back to the inline mode using the method switchInlineQuery inside the Web App.
  property web_app : Hamilton::Types::WebAppInfo | Nil

  # Deep-linking parameter for the /start message sent to the bot when a user presses the button. 1-64 characters, only `A-Z`, `a-z`, `0-9`, `_` and `-` are allowed.
  property start_parameter : String | Nil
end