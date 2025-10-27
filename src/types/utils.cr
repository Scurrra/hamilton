# Module that encapsulates type construction and serialization logic (initialize from `**params` and `from_json`; `to_json`).
module Hamilton::Types::Common
  include JSON::Serializable

  def self.new(**params)
    instance = {{@type.name}}.allocate
    {% for var, index in @type.instance_vars %} 
      {% unless var.name.stringify == "non_nil_fields" %}
        {% if Nil <= var.type %}
        instance.{{var.name}} = params[{{var.name.stringify}}]?
        {% else %}
        instance.{{var.name}} = params[{{var.name.stringify}}]
        {% end %}
      {% end %}   
    {% end %}
    
    instance.after_initialize
    instance
  end

  # def initialize
  #   {% for var, index in @type.instance_vars %} {% unless var.name.stringify == "non_nil_fields" %}
  #   @{{var.name}}, {% end %}
  #   {% end %}
  
  #   after_initialize
  # end

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
end