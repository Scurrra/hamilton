require "json"

# Describes a service message about a regular gift that was sent or received.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiftInfo
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

  # Information about the gift.
  property gift : Hamilton::Types::Gift

  # Unique identifier of the received gift for the bot; only present for gifts received on behalf of business accounts.
  property owned_gift_id : String | Nil

  # Number of Telegram Stars that can be claimed by the receiver by converting the gift; omitted if conversion to Telegram Stars is impossible.
  property convert_star_count : Int32 | Nil

  # Number of Telegram Stars that were prepaid by the sender for the ability to upgrade the gift.
  property prepaid_upgrade_star_count : Int32 | Nil

  # True, if the gift can be upgraded to a unique gift.
  property can_be_upgraded : Bool | Nil

  # Text of the message that was added to the gift.
  property text : String | Nil
  
  # Special entities that appear in the text.
  property entities : Array(Hamilton::Types::MessageEntity) | Nil

  # True, if the sender and gift text are shown only to the gift receiver; otherwise, everyone will be able to see them.
  property is_private : Bool | Nil
end