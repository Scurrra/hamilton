require "json"

# Contains information about the start page settings of a Telegram Business account.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::BusinessIntro
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

  # Title text of the business intro.
  property title : String | Nil

  # Message text of the business intro.
  property message : String | Nil

  # Sticker of the business intro.
  property sticker : Hamilton::Types::Sticker
end