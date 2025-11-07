# Module that encapsulates type construction and serialization logic (initialize from `**params` and `from_json`; `to_json`).
module Hamilton::Types::Common
  
  macro included

  def self.new(**params)
    instance = allocate
    instance.initialize(params)
    instance
  end

  def initialize(params)
    {% verbatim do %}
    {% for var, index in @type.instance_vars %} 
      {% unless var.name.stringify == "non_nil_fields" %}
        {% if Nil <= var.type %}
        @{{var.name}} = params[{{var.name.stringify}}]?
        {% else %}
        @{{var.name}} = params[{{var.name.stringify}}]
        {% end %}

        unless @{{var.name}}.nil?
          @non_nil_fields.push({{var.name.stringify}})
        end
      {% end %}   
    {% end %}
    {% end %}
  end

  # List of available non-nil fields.
  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String
  end

  # :nodoc:
  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end
end