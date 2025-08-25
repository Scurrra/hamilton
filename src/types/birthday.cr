require "json"

# Describes the birthdate of a user.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Birthdate
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

  # Day of the user's birth; 1-31.
  property day : Int32

  # Month of the user's birth; 1-12.
  property month : Int32

  # Year of the user's birth.
  property year : Int32 | Nil
end