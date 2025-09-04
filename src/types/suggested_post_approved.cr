require "json"

# Describes a service message about the approval of a suggested post.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostApproved
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

  # Message containing the suggested post. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Amount paid for the post.
  property price : Hamilton::Types::SuggestedPostPrice | Nil

  # Date when the post will be published.
  property send_date : Int32
end