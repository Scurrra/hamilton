require "json"

# This object contains information about a paid media purchase.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PaidMediaPurchased
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

  # User who purchased the media.
  property from : Hamilton::Types::User

  # Bot-specified paid media payload.
  property paid_media_payload : Int32
end