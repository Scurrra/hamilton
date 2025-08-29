require "json"

# This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don't exceed 10MB.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportFile
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

  # File size in bytes.
  property file_size : Int32

  # Unix time when the file was uploaded.
  property file_date : Int32
end