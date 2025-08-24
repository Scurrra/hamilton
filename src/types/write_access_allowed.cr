require "json"

# This object represents a service message about a user allowing a bot to write messages after adding it to the attachment menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::WriteAccessAllowed
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

  # True, if the access was granted after the user accepted an explicit request from a Web App sent by the method requestWriteAccess.
  property from_request : Bool | Nil

  # Name of the Web App, if the access was granted when the Web App was launched from a link.
  property web_app_name : String | Nil

  # True, if the access was granted when the bot was added to the attachment or side menu.
  property from_attachment_menu : Bool | Nil
end