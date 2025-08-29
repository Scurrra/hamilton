require "json"

# This object represents one row of the high scores table for a game.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::GameHighScore
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

  # Position in high score table for the game.
  property position : Int32

  # User.
  property user : Hamilton::Types::User

  # Score.
  property score : Int32
end