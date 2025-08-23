require "json"

# This object represents a voice note.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Voice
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

  # Duration of the audio in seconds as defined by the sender.
  property duration : Int32

  # MIME type of the file as defined by the sender.
  property mime_type : String | Nil

  # File size in bytes.
  property file_size : Int64 | Nil
end