require "json"

# This object represents an inline keyboard button that copies specified text to the clipboard.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::CopyTextButton
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

  # The text to be copied to the clipboard; 1-256 characters.
  property text : String
end