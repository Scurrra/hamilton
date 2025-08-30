require "http/client"

require "./*"

# Class that is used for communication with Bot API endpoints. 
class Hamilton::Api

  # :nodoc:
  getter env : Symbol

  # :nodoc:
  getter token : String

  # :nodoc:
  getter url : String

  # :nodoc:
  getter path : String

  # :nodoc:
  getter client : HTTP::Client

  # API class constructor.
  #
  # Params:
  # - `token` -- Bot unique token.
  # - `url` -- Bot API URL. Default is "https://api.telegram.org", pass your URL if you are using your own server.
  # - `env` -- Type of the environment. `:test` is used for testing and inserts `test/` in the endpoint after bot token.
  def initialize(@token, @url = "https://api.telegram.org", @env = :prod)
    @path = @env == :test ? "/bot#{@token}/test/" : "/bot#{@token}/" 
    @client = HTTP::Client.new @url
  end

  {% begin %}
  {% for method, info in Hamilton::Api::ENDPOINTS %}
    {% for doc, index in info[:docs] %} # {{doc.id}}
    #
    {% end %}   {% if info[:params].size > 0 %} # Params:
    #
    {% for param, pinfo in info[:params] %} # `{{param.id}} : {{pinfo[:type]}}`
    #
    {% for doc, index in pinfo[:docs] %} # > {{doc.id}}
    # >
    {% end %}   #
    {% end %}   {% end %}   #
    def {{method.id}}(**params)
      
    end
  {% end %}
  {% debug %}
  {% end %}
end