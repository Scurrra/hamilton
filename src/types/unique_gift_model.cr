require "json"

# This object describes the model of a unique gift.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UniqueGiftModel
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

  # The sticker that represents the unique gift.
  property sticker : Hamilton::Types::Sticker

  # The number of unique gifts that receive this model for every 1000 gifts upgraded.
  property rarity_per_mille : Int32
end