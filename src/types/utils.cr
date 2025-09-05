# Module that encapsulates type construction and serialization logic (initialize from `**params` and `from_json`; `to_json`).
module Hamilton::Types::Common
  include JSON::Serializable

  def initialize(**params)
    # {%begin%}
    {% for var, index in @type.instance_vars %} {% unless var.name.stringify == "non_nil_fields" %}
    @{{var.name}} = params[{{var.name.stringify}}]?
    {% end %}   {% end %}
    # {%debug%}
    # {%end%}

    # TODO: find out why the type is infered wrong in `%var{name} = ...` sometimes.
    # {%begin%}
    # {% properties = {} of Nil => Nil %}
    # {% for ivar in @type.instance_vars %}
    #   {% unless ivar.id.stringify == "non_nil_fields" %}
    #   {%
    #     properties[ivar.id] = {
    #       key: ivar.id.stringify,
    #       type: ivar.type,
    #     }
    #   %}
    #   {% end %}
    # {% end %}
    # {% for name, value in properties %}
    #   %var{name} = uninitialized {{value[:type]}}
    #   %found{name} = false
    # {% end %}
    # params_keys, i = params.keys, 0
    # while i < params_keys.size
    #   key = params_keys[i]
    #   case key.to_s
    #   {% for name, value in properties %}
    #   when {{value[:key]}}
    #     if params.has_key?({{value[:key]}})
    #       if param = params[{{value[:key]}}]?
    #         pp typeof(param)
    #         unless typeof(param) <= {{value[:type]}}
    #           raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, typeof(param))
    #         end
    #         # %var{name} = {{value[:type]}}.from_json param.to_json # works as expected (raises error when should)
    #         # %var{name} = {{value[:type]}}.cast param # wrong type inference
    #         %var{name} = param # wrong type inference
    #         %found{name} = true
    #       else
    #         unless Nil < {{value[:type]}}
    #           raise Hamilton::Errors::FieldTypeMissmatch.new(key, {{value[:type]}}, Nil)
    #         end
    #       end
    #     end
    #   {% end %}
    #   else
    #     raise Hamilton::Errors::UnknownField.new(key)
    #   end
    #   i += 1
    # end
    # {% for name, value in properties %}
    #   if %found{name}
    #     @{{name}} = %var{name}
    #   {% unless Nil < value[:type] %}
    #   else
    #     raise Hamilton::Errors::MissingField.new({{name.stringify}})
    #   {% end %}
    #   end
    # {% end %}
    # {%end%}
    
    after_initialize
  end

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