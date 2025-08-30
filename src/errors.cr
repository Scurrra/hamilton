require "http/status"

# Custom errors.
module Hamilton::Errors
  
  # Exception raised when a method parameter passed in `**params` has wrong type.
  class ParamTypeMissmatch < Exception
    def initialize(param_name : String | Symbol, type : Class)
      super("Parameter `#{param_name}` must be of type #{type}")
    end
  end

  # Exception raised when `**params` does not contain a required param.
  class MissingParam < Exception
    def initialize(param_name : String | Symbol)
      super("Parameter `#{param_name}` must be specified")
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