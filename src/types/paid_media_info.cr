require "json"

# Describes the paid media added to a message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaInfo
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

  # The number of Telegram Stars that must be paid to buy access to the media.
  property star_count : Int32

  # Information about the paid media.
  property paid_media : Array(Hamilton::Types::PaidMedia)
end