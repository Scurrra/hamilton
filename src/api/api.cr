require "http"
require "http/client"
require "json"

require "./*"
require "../types"

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

  # API class constructor.
  #
  # Params:
  # - `token` -- Bot unique token.
  # - `url` -- Bot API URL. Default is "https://api.telegram.org", pass your URL if you are using your own server.
  # - `env` -- Type of the environment. `:test` is used for testing and inserts `test/` in the endpoint after bot token.
  def initialize(@token, @url = "https://api.telegram.org", @env = :prod)
    @path = @env == :test ? "#{@url}/bot#{@token}/test/" : "#{@url}/bot#{@token}/"
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
      # compiler complained for missing fields in NamedTuple, so...
      params = params.to_h

      # default `Content-Type` header for fields in `Content-Type: multipart/form-data`
      field_headers = HTTP::Headers{"Content-Type" => "application/json"}

      # indicator for files, (to be removed)
      # has_files = false

      body = ""
      boundary = MIME::Multipart.generate_boundary
      # type check and form building
      {% if info.has_key?(:params) && info[:params].size > 0 %}
      io = IO::Memory.new
      builder = HTTP::FormData::Builder.new(io, boundary)
      {% for param, pinfo in info[:params] %}
        unless params.has_key?({{param}})
          unless Nil < {{pinfo[:type].resolve}}
            raise Hamilton::Errors::MissingParam.new({{param}})
          end
        else
          unless typeof(params[{{param}}]) <= {{pinfo[:type].resolve}}
            raise Hamilton::Errors::ParamTypeMissmatch.new({{param}}, {{pinfo[:type]}}, typeof(params[{{param}}]))
          end

          {% if Hamilton::Types::InputFile <= pinfo[:type].resolve %}
          case params[{{param}}]
          when Hamilton::Types::InputFile
            builder.field({{param.id.stringify}}, "attach://#{params[{{param}}].filename}")
            builder.file(params[{{param}}].filename, params[{{param}}].file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].filename))
            # has_files = true
          else
            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          end
          {% elsif Hamilton::Types::InputMedia == pinfo[:type].resolve %}
          case params[{{param}}]
          in Hamilton::Types::InputMediaPhoto
            # media itself
            if typeof(params[{{param}}].media).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].media.filename, params[{{param}}].media.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].media.filename))
              params[{{param}}].media = "attach://#{params[{{param}}].media.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          in Hamilton::Types::InputMediaVideo
            # media itself
            if typeof(params[{{param}}].media).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].media.filename, params[{{param}}].media.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].media.filename))
              params[{{param}}].media = "attach://#{params[{{param}}].media.filename}"
              # has_files = true
            end

            # thumbnail
            if typeof(params[{{param}}].thumbnail).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].thumbnail.filename, params[{{param}}].thumbnail.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].thumbnail.filename))
              params[{{param}}].thumbnail = "attach://#{params[{{param}}].thumbnail.filename}"
              # has_files = true
            end

            # cover
            if typeof(params[{{param}}].cover).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].cover.filename, params[{{param}}].cover.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].cover.filename))
              params[{{param}}].cover = "attach://#{params[{{param}}].cover.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          in Hamilton::Types::InputMediaAnimation
            # media itself
            if typeof(params[{{param}}].media).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].media.filename, params[{{param}}].media.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].media.filename))
              params[{{param}}].media = "attach://#{params[{{param}}].media.filename}"
              # has_files = true
            end

            # thumbnail
            if typeof(params[{{param}}].thumbnail).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].thumbnail.filename, params[{{param}}].thumbnail.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].thumbnail.filename))
              params[{{param}}].thumbnail = "attach://#{params[{{param}}].thumbnail.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          in Hamilton::Types::InputMediaAudio
            # media itself
            if typeof(params[{{param}}].media).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].media.filename, params[{{param}}].media.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].media.filename))
              params[{{param}}].media = "attach://#{params[{{param}}].media.filename}"
              # has_files = true
            end

            # thumbnail
            if typeof(params[{{param}}].thumbnail).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].thumbnail.filename, params[{{param}}].thumbnail.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].thumbnail.filename))
              params[{{param}}].thumbnail = "attach://#{params[{{param}}].thumbnail.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          in Hamilton::Types::InputMediaDocument
            # media itself
            if typeof(params[{{param}}].media).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].media.filename, params[{{param}}].media.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].media.filename))
              params[{{param}}].media = "attach://#{params[{{param}}].media.filename}"
              # has_files = true
            end

            # thumbnail
            if typeof(params[{{param}}].thumbnail).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].thumbnail.filename, params[{{param}}].thumbnail.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].thumbnail.filename))
              params[{{param}}].thumbnail = "attach://#{params[{{param}}].thumbnail.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          end
          {% elsif Array(Hamilton::Types::InputMediaAudio | Hamilton::Types::InputMediaDocument | Hamilton::Types::InputMediaPhoto | Hamilton::Types::InputMediaVideo) == pinfo[:type].resolve %}
          params[{{param}}].each do |media|
            case media
            in Hamilton::Types::InputMediaAudio
              # media itself
              if typeof(media.media).is_a? Hamilton::Types::InputFile
                builder.file(media.media.filename, media.media.file, HTTP::FormData::FileMetadata.new(filename: media.media.filename))
                media.media = "attach://#{media.media.filename}"
                # has_files = true
              end

              # thumbnail
              if typeof(media.thumbnail).is_a? Hamilton::Types::InputFile
                builder.file(media.thumbnail.filename, media.thumbnail.file, HTTP::FormData::FileMetadata.new(filename: media.thumbnail.filename))
                media.thumbnail = "attach://#{media.thumbnail.filename}"
                # has_files = true
              end
            in Hamilton::Types::InputMediaDocument
              # media itself
              if typeof(media.media).is_a? Hamilton::Types::InputFile
                builder.file(media.media.filename, media.media.file, HTTP::FormData::FileMetadata.new(filename: media.media.filename))
                media.media = "attach://#{media.media.filename}"
                # has_files = true
              end

              # thumbnail
              if typeof(media.thumbnail).is_a? Hamilton::Types::InputFile
                builder.file(media.thumbnail.filename, media.thumbnail.file, HTTP::FormData::FileMetadata.new(filename: media.thumbnail.filename))
                media.thumbnail = "attach://#{media.thumbnail.filename}"
                # has_files = true
              end
            in Hamilton::Types::InputMediaPhoto
              # media itself
              if typeof(media.media).is_a? Hamilton::Types::InputFile
                builder.file(media.media.filename, media.media.file, HTTP::FormData::FileMetadata.new(filename: media.media.filename))
                media.media = "attach://#{media.media.filename}"
                # has_files = true
              end
            in Hamilton::Types::InputMediaVideo
              # media itself
              if typeof(media.media).is_a? Hamilton::Types::InputFile
                builder.file(media.media.filename, media.media.file, HTTP::FormData::FileMetadata.new(filename: media.media.filename))
                media.media = "attach://#{media.media.filename}"
                # has_files = true
              end

              # thumbnail
              if typeof(media.thumbnail).is_a? Hamilton::Types::InputFile
                builder.file(media.thumbnail.filename, media.thumbnail.file, HTTP::FormData::FileMetadata.new(filename: media.thumbnail.filename))
                media.thumbnail = "attach://#{media.thumbnail.filename}"
                # has_files = true
              end

              # cover
              if typeof(media.cover).is_a? Hamilton::Types::InputFile
                builder.file(media.cover.filename, media.cover.file, HTTP::FormData::FileMetadata.new(filename: media.cover.filename))
                media.cover = "attach://#{media.cover.filename}"
                # has_files = true
              end
            end
          end
          builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          {% elsif Array(Hamilton::Types::InputPaidMedia) == pinfo[:type].resolve %}
          params[{{param}}].each do |paid_media|
            case paid_media
            in Hamilton::Types::InputPaidMediaPhoto
              # media itself
              if typeof(paid_media.media).is_a? Hamilton::Types::InputFile
                builder.file(paid_media.media.filename, paid_media.media.file, HTTP::FormData::FileMetadata.new(filename: paid_media.media.filename))
                paid_media.media = "attach://#{paid_media.media.filename}"
                # has_files = true
              end
            in Hamilton::Types::InputPaidMediaVideo
              # media itself
              if typeof(paid_media.media).is_a? Hamilton::Types::InputFile
                builder.file(paid_media.media.filename, paid_media.media.file, HTTP::FormData::FileMetadata.new(filename: paid_media.media.filename))
                paid_media.media = "attach://#{paid_media.media.filename}"
                # has_files = true
              end

              # thumbnail
              if typeof(paid_media.thumbnail).is_a? Hamilton::Types::InputFile
                builder.file(paid_media.thumbnail.filename, paid_media.thumbnail.file, HTTP::FormData::FileMetadata.new(filename: paid_media.thumbnail.filename))
                paid_media.thumbnail = "attach://#{paid_media.thumbnail.filename}"
                # has_files = true
              end

              # cover
              if typeof(paid_media.cover).is_a? Hamilton::Types::InputFile
                builder.file(paid_media.cover.filename, paid_media.cover.file, HTTP::FormData::FileMetadata.new(filename: paid_media.cover.filename))
                paid_media.cover = "attach://#{paid_media.cover.filename}"
                # has_files = true
              end
            end
          end
          builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          {% elsif Hamilton::Types::InputSticker == pinfo[:type].resolve %}
          if typeof(params[{{param}}].sticker).is_a? Hamilton::Types::InputFile
            builder.file(params[{{param}}].sticker.filename, params[{{param}}].sticker.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].sticker.filename))
            params[{{param}}].sticker = "attach://#{params[{{param}}].sticker.filename}"
            # has_files = true
          end
          builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          {% elsif Array(Hamilton::Types::InputSticker) == pinfo[:type].resolve %}
          params[{{param}}].each do |stiker|
            if typeof(stiker.sticker).is_a? Hamilton::Types::InputFile
              builder.file(stiker.sticker.filename, stiker.sticker.file, HTTP::FormData::FileMetadata.new(filename: stiker.sticker.filename))
              stiker.sticker = "attach://#{stiker.sticker.filename}"
              # has_files = true
            end
          end
          builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          {% elsif Hamilton::Types::InputStoryContent == pinfo[:type].resolve %}
          case params[{{param}}]
          in Hamilton::Types::InputStoryContentPhoto
            # media itself
            if typeof(params[{{param}}].photo).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].photo.filename, params[{{param}}].photo.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].photo.filename))
              params[{{param}}].photo = "attach://#{params[{{param}}].photo.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          in Hamilton::Types::InputStoryContentVideo
            # media itself
            if typeof(params[{{param}}].video).is_a? Hamilton::Types::InputFile
              builder.file(params[{{param}}].video.filename, params[{{param}}].video.file, HTTP::FormData::FileMetadata.new(filename: params[{{param}}].video.filename))
              params[{{param}}].video = "attach://#{params[{{param}}].video.filename}"
              # has_files = true
            end

            builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          end
          {% else %}
          builder.field({{param.id.stringify}}, params[{{param}}].to_json, field_headers)
          {% end %}

        end
      {% end %}
      builder.finish
      body += io.to_s
      {% end %}

      response = HTTP::Client.post(
        @path + {{method}},
        headers: HTTP::Headers{"Content-Type" => "multipart/form-data; boundary=#{boundary}"},
        body: body
      )

      # response = if has_files
      #   HTTP::Client.post(
      #     @path + {{method}},
      #     headers: HTTP::Headers{"Content-Type" => "multipart/form-data; boundary=#{boundary}"},
      #     body: body
      #   )
      # else
      #   HTTP::Client.post(
      #     @path + {{method}},
      #     headers: HTTP::Headers{"Content-Type" => "application/json"},
      #     body: params.to_json
      #   )
      # end

      if response.status.ok?
        if body = response.body?
          api_result = {{info[:return_type]}}.from_json body
          if api_result.ok
            return api_result.result
          else
            raise Hamilton::Errors::ApiEndpointError.new({{method}}, response.status, "inside body status is not ok")      
          end
        end
      else
        raise Hamilton::Errors::ApiEndpointError.new({{method}}, response.status)
      end
    end

  {% end %}
end
