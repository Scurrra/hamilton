require "json"

# Describes Telegram Passport data shared with the bot by the user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportData
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

  # Array with information about documents and other Telegram Passport elements that was shared with the bot.
  property data : Array(Hamilton::Types::EncryptedPassportElement)

  # Encrypted credentials required to decrypt the data.
  property credentials : Hamilton::Types::EncryptedCredentials
end