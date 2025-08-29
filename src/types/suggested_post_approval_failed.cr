require "json"

# Describes a service message about the failed approval of a suggested post. Currently, only caused by insufficient user funds at the time of approval.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::SuggestedPostApprovalFailed
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
  
  # Message containing the suggested post whose approval has failed. Note that the Message object in this field will not contain the reply_to_message field even if it itself is a reply.
  property suggested_post_message : Hamilton::Types::Message | Nil

  # Expected price of the post.
  property price : Hamilton::Types::SuggestedPostPrice
end