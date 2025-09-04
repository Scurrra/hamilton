require "http/status"

# Custom errors.
module Hamilton::Errors

  # Exception raised when a method parameter passed in `**params` has wrong type.
  class ParamTypeMissmatch < Exception
    def initialize(param_name : String | Symbol, type : Class, param_type : Class)
      super("Parameter `#{param_name}` must be of type #{type}, but found #{param_type}")
    end
  end

  # Exception raised when `**params` does not contain a required param.
  class MissingParam < Exception
    def initialize(param_name : String | Symbol)
      super("Parameter `#{param_name}` must be specified")
    end
  end

  # Exception raised when a method parameter passed in `**params` has wrong type.
  class FieldTypeMissmatch < Exception
    def initialize(param_name : String | Symbol, type : Class, param_type : Class)
      super("Field `#{param_name}` must be of type #{type}, but found #{param_type}")
    end
  end

  # Exception raised when `**params` does not contain a required param.
  class MissingField < Exception
    def initialize(param_name : String | Symbol)
      super("Field `#{param_name}` must be specified")
    end
  end

  # Exception raised when `**params` contains an unknown param.
  class UnknownField < Exception
    def initialize(param_name : String | Symbol)
      super("Field `#{param_name}` is unknown")
    end
  end

  # Exception raised when something wrong is returned.
  class ApiEndpointError < Exception
    def initialize(endpoint : String, status : HTTP::Starus)
      message = "Endpoint `#{endpoint}` returned with status #{status.code}"
      if description = status.description
        message += " :: #{description}"
      end
      super(message)
    end
  end
end
