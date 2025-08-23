require "json"

# This object represents a phone contact.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Contact
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

  # Contact's phone number.
  property phone_number : String

  # Contact's first name.
  property first_name : String

  # Contact's last name.
  property last_name : String | Nil

  # Contact's user identifier in Telegram.
  property user_id : Int64 | Nil

  # Additional data about the contact in the form of a vCard.
  property vcard : String | Nil
end