require "json"

# This object represents a service message about the creation of a scheduled giveaway.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GiveawayCreated
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

  # The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only.
  property prize_star_count : Int32 | Nil
end