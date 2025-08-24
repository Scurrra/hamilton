require "json"

# Contains parameters of a post that is being suggested by the bot.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostParameters
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

  # Proposed price for the post. If the field is omitted, then the post is unpaid.
  property price : Hamilton::Types::SuggestedPostPrice | Nil

  # Proposed send date of the post. If specified, then the date must be between 300 second and 2678400 seconds (30 days) in the future. If the field is omitted, then the post can be published at any time within 30 days at the sole discretion of the user who approves it.
  property send_date : Int32 | Nil
end