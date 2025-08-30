require "http/client"

require "./*"

# Class that is used for communication with Bot API endpoints. 
class Hamilton::Api

  getter env : Symbol
  getter token : String
  getter url : String
  getter path : String
  getter client : HTTP::Client

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
    {% for param, pinfo in info[:params] %} # {{param.id}} : {{pinfo[:type]}}
    #
    {% for doc, index in pinfo[:docs] %} # {{doc.id}}
    #
    {% end %}   {% end %}   {% end %}   #
    def {{method.id}}(**params)
      
    end
  {% end %}
  {% debug %}
  {% end %}
end