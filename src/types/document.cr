require "json"

# This object represents a general file (as opposed to photos, voice messages and audio files).
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Document
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

  # Identifier for this file, which can be used to download or reuse the file.
  property file_id : String

  # Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
  property file_unique_id : String

  # Document thumbnail as defined by the sender.
  property thumbnail : Hamilton::Types::PhotoSize | Nil

  # Original filename as defined by the sender.
  property file_name : String | Nil

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end