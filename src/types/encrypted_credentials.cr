require "json"

# Describes data required for decrypting and authenticating EncryptedPassportElement.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::EncryptedCredentials
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

  # Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for `EncryptedPassportElement` decryption and authentication.
  property data : String

  # Base64-encoded data hash for data authentication.
  property hash : String

  # Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption.
  property secret : String
end