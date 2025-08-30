require "json"

# This object represents the contents of a file to be uploaded. Must be posted using `multipart/form-data` in the usual way that files are uploaded via the browser.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputFile
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

  # File to be sent.
  @[JSON::Field(ignore: true)]
  property file : File

  # Filename.
  @[JSON::Field(ignore: true)]
  property filename : File | Nil
end