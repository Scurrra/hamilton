require "json"

# This object represents a video message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::VideoNote
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

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Video width and height (diameter of the video message) as defined by the sender.
  property length : Int32

  # Duration of the video in seconds as defined by the sender.
  property duration : Int32

  # Video thumbnail.
  property thumbnail : Hamilton::Types::PhotoSize | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end