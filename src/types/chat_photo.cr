require "json"

# This object represents a chat photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatPhoto
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

  # File identifier of small (160x160) chat photo. This `file_id` can be used only for photo download and only for as long as the photo is not changed.
  property small_file_id : String

  # Unique file identifier of small (160x160) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property small_file_unique_id : String

  # File identifier of big (640x640) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.
  property big_file_id : String

  # Unique file identifier of big (640x640) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property big_file_unique_id : String
end