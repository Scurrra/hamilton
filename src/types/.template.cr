require "json"

@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::Update
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_nillable : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_nillable.push({{field}})
    end
    {% end %}

    @non_nil_nillable.delete("non_nil_nillable")
  end

  property update_id : Int32

  property message : Hamilton::Types::Message | Nil
end