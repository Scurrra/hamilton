require "json"

# Describes an amount of Telegram Stars.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::StarAmount
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

  # Integer amount of Telegram Stars, rounded to 0; can be negative.
  property amount : Int32

  # The number of 1/1000000000 shares of Telegram Stars; from -999999999 to 999999999; can be negative if and only if amount is non-positive.
  property nanostar_amount : Int32 | Nil
end