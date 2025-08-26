require "json"

# This object describes the colors of the backdrop of a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftBackdropColors
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

  # The color in the center of the backdrop in RGB format.
  property center_color : Int32

  # The color on the edges of the backdrop in RGB format.
  property edge_color : Int32

  # The color to be applied to the symbol in RGB format.
  property symbol_color : Int32

  # The color for the text on the backdrop in RGB format.
  property text_color : Int32
end