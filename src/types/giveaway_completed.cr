require "json"

# This object represents a service message about the completion of a giveaway without public winners.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiveawayCompleted
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

  # Number of winners in the giveaway.
  property winner_count : Int32

  # Number of undistributed prizes.
  property unclaimed_prize_count : Int32 | Nil

  # Message with the giveaway that was completed, if it wasn't deleted.
  property giveaway_message : Hamilton::Types::Message | Nil

  # True, if the giveaway is a Telegram Star giveaway. Otherwise, currently, the giveaway is a Telegram Premium giveaway.
  property is_star_giveaway : Bool | Nil
end