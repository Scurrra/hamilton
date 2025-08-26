require "json"

# This object describes the backdrop of a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftBackdrop
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

  # Name of the model.
  property name : String

  # Colors of the backdrop.
  property colors : Hamilton::Types::UniqueGiftBackdropColors

  # The number of unique gifts that receive this backdrop for every 1000 gifts upgraded.
  property rarity_per_mille : Int32
end