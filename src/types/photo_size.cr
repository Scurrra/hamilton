require "json"

# This object represents one size of a photo or a file / sticker thumbnail.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PhotoSize
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

  # Photo width.
  property width : Int32

  # Photo height.
  property height : Int32

  # File size in bytes.
  property file_size : Int32
end