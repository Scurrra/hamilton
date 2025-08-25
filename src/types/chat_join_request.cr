require "json"

# Represents a join request sent to a chat.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::ChatJoinRequest
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

  # Chat to which the request was sent.
  property chat : Hamilton::Types::Chat

  # User that sent the join request.
  property user : Hamilton::Types::User

  # Identifier of a private chat with the user who sent the join request. The bot can use this identifier for 5 minutes to send messages until the join request is processed, assuming no other administrator contacted the user.
  property user_chat_id : Int32

  # Date the request was sent in Unix time.
  property date : Int32

  # Bio of the user.
  property bio : String | Nil

  # Chat invite link that was used by the user to send the join request.
  property invite_link : Hamilton::Types::ChatInviteLink | Nil
end