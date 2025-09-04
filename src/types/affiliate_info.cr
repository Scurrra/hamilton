require "json"

# Contains information about the affiliate that received a commission via this transaction.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::AffiliateInfo
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

  # The bot or the user that received an affiliate commission if it was received by a bot or a user.
  property affiliate_user : Hamilton::Types::User | Nil

  # The chat that received an affiliate commission if it was received by a chat.
  property affiliate_chat : Hamilton::Types::Chat | Nil

  # The number of Telegram Stars received by the affiliate for each 1000 Telegram Stars received by the bot from referred users.
  property commission_per_mille : Int32

  # Integer amount of Telegram Stars received by the affiliate from the transaction, rounded to 0; can be negative for refunds.
  property amount : Int32

  # The number of 1/1000000000 shares of Telegram Stars received by the affiliate; from -999999999 to 999999999; can be negative for refunds.
  property nanostar_amount : Int32 | Nil
end