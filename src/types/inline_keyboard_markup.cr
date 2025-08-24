require "json"

# This object represents an inline keyboard that appears right next to the message it belongs to.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineKeyboardMarkup
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

  # Array of button rows, each represented by an Array of InlineKeyboardButton objects.
  property inline_keyboard : Array(Array(Hamilton::Types::InlineKeyboardButton))
end