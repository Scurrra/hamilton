require "http"
require "http/client"
require "json"

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

  {% for method, info in Hamilton::Api::ENDPOINTS %}
    {% for doc, index in info[:docs] %} # {{doc.id}}
    #
    {% end %}   {% if info.has_key?(:params) && info[:params].size > 0 %} # Params:
    #
    {% for param, pinfo in info[:params] %} # `{{param.id}} : {{pinfo[:type]}}`
    #
    {% for doc, index in pinfo[:docs] %} # > {{doc.id}}
    # >
    {% end %}   #
    {% end %}   {% end %}   #
    def {{method.id}}(**params)
      body = ""
      # type check and form building
      {% if info.has_key?(:params) && info[:params].size > 0 %}
      io = IO::Memory.new
      boundary = MIME::Multipart.generate_boundary
      builder = HTTP::FormData::Builder.new(io, boundary)
      {% for param, pinfo in info[:params] %}
        unless params.has_key?({{param}})
          unless Nil < {{pinfo[:type]}}
            raise Hamilton::Errors::MissingParam.new({{param}})
          end
        else
          unless typeof(params[{{param}}]) < {{pinfo[:type]}}
            raise Hamilton::Errors::ParamTypeMissmatch.new({{param}}, {{pinfo[:type]}})
          end

          if typeof(params[{{param}}]) == Hamilton::Types::InputFile
            builder.file({{param}}, params[{{param}}].file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].filename))
          else
            builder.field({{param}}, params[{{param}}].to_json)
          end
        end
      {% end %}
      builder.finish
      body += io.to_s
      {% end %}

      response = @client.post(
        @path + {{method}},
        headers: HTTP::Headers{"Content-Type" => "multipart/form-data; boundary=#{boundary}"},
        body: body
      )

      if response.status.ok?
        if body = response.body?
          return {{info[:return_type]}}.from_json body
        end
      else
        raise Hamilton::Errors::ApiEndpointError.new({{method}}, response.status)
      end
    end
  {% end %}
end
