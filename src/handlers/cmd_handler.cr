require "../handler"
require "../context"
require "log"

annotation Handle
end

annotation For
end

module Hamilton::CmdHandler
  include Hamilton::Handler
  
  property mapper : Hash(Symbol, Hash(String | Symbol, Symbol))
  property context : Hamilton::Context
  
  property log : Log

  def initialize
    @log = Log.for("Hamilton::Bot")
    @context = Hamilton::Context.new default_method: :root
    @mapper = {:root => Hash(String | Symbol, Symbol).new}
  end

  # TODO: override call

  macro method_added(method)
    {% if method.annotation(Handle) %}
      {% if method.annotation(Handle).named_args.has_key?(:command) %}
      %type = :command
      %value = {{method.annotation(Handle)[:command].stringify}}
      {% elsif method.annotation(Handle).named_args.has_key?(:text) %}
      %type = :text
      %value = {{method.annotation(Handle)[:text].stringify}}
      {% else %}
      %type = :other
      %value = {{method.annotation(Handle)[0].symbolize}}
      {% end %}

      {% for method_ in method.annotation(For).args %}
      @mapper[{{mapper_.symbolize}}][%value] = {{method.name.symbolize}}
      {% end %}

      {% if method.annotation(For).args.size == 0 %}
        @mapper[:root][%value] = {{method.name.symbolize}}
      {% end %}

      @mapper[{{method.name.symbolize}}] = Hash(String | Symbol, Symbol).new
    {% end %}
  end

end