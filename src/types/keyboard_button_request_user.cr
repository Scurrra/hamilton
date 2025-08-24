require "json"

# This object defines the criteria used to request suitable users. Information about the selected users will be shared with the bot when the corresponding button is pressed.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::KeyboardButtonRequestUsers
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

  # Signed 32-bit identifier of the request that will be received back in the UsersShared object. Must be unique within the message.
  property request_id : Int32

  # Pass True to request bots, pass False to request regular users. If not specified, no additional restrictions are applied.
  property user_is_bot : Bool | Nil

  # Pass True to request premium users, pass False to request non-premium users. If not specified, no additional restrictions are applied.
  property user_is_premium : Bool | Nil

  # The maximum number of users to be selected; 1-10. Defaults to 1.
  property max_quantity : Int32 | Nil

  # Pass True to request the users' first and last names.
  property request_name : Bool | Nil

  # Pass True to request the users' usernames.
  property request_username : Bool | Nil

  # Pass True to request the users' photos.
  property request_photo : Bool | Nil
end