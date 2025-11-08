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

  # Exception raised when `CmdHandler` method doesn't contain parameter it handles.
  class MissingCmdHandlerMethodParam < Exception
    def initialize(param_name : String | Symbol)
      super("Parameter `#{param_name}` must be specified in CmdHandler method")
    end
  end

  # Exception raised when `CmdHandler` method's `Handle` annotation doesn't contain any arguments.
  class MissingCmdHandlerMethodAnnotationArg < Exception
    def initialize(annotation_name : String | Symbol)
      super("At least one argument must be specified in CmdHandler methods #{annotation_name} annotation")
    end
  end

  # Exception raised when `CmdHandler` method's `Handle` annotation argument is not supported.
  class UnsupportedCmdHandlerPayloadType < Exception
    def initialize(payload_type : String | Symbol)
      super("#{payload_type} payload type is not supported by CmdHandler")
    end
  end

  # Exception raised when `CmdHandler` method's tries to handle unsupported command.
  class UnsupportedCmdHandlerCommand < Exception
    def initialize(cmd : String = "/signal", reason : String = " with `:async` flag on")
      super("`#{cmd}` command is not allowed in CmdHandler#{reason}")
    end
  end

  # Exception raised when `CmdHandler` method tries to handle wrong command.
  class WrongCmdHandlerCommand < Exception
    def initialize(method : String | Symbol, cmd : String)
      super("The method `#{method}` is not suited for the command `#{cmd}`")
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
    def initialize(endpoint : String, status : HTTP::Status, message m : String = "")
      message = "Endpoint `#{endpoint}` returned with status #{status.code}"
      if description = status.description
        message += " :: #{description}"
      end
      if m != ""
        message += ", BUT #{m}"
      end
      super(message)
    end
  end
end
