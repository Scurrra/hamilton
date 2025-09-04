require "json"

# This object represent a user's profile pictures.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::UserProfilePhotos
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

  # Total number of profile pictures the target user has.
  property total_count : Int32

  # Requested profile pictures (in up to 4 sizes each).
  property photos : Array(Array(Hamilton::Types::PhotoSize))
end