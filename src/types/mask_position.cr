require "json"

# This object describes the position on faces where a mask should be placed by default.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MaskPosition
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

  # The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.
  property point : String

  # Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.
  property x_shift : Float32

  # Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.
  property y_shift : Float32

  # Mask scaling coefficient. For example, 2.0 means double size.
  property scale : Float32
end