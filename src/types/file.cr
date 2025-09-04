require "json"

# This object represents a file ready to be downloaded. The file can be downloaded via the link `https://api.telegram.org/file/bot<token>/<file_path>`. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile.
#
# NOTE: The maximum file size to download is 20 MB.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::File
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

  # File size in bytes.
  property file_size : Int64 | Nil

  # File path. Use `https://api.telegram.org/file/bot<token>/<file_path>` to get the file.
  property file_path : String | Nil
end