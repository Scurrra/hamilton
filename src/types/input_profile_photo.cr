require "json"

# A static profile photo in the .JPG format.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputProfilePhotoStatic
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the profile photo, must be "static".
  property type : String

  # The static profile photo. Profile photos can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the photo was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property photo : String
end

# An animated profile photo in the MPEG4 format.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputProfilePhotoAnimated
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  property non_nil_fields : Array(String) = [] of String

  def after_initialize
    {% for field, index in @type.instance_vars.map &.name.stringify %}
    unless @{{field.id}}.nil?
      @non_nil_fields.push({{field}})
    end
    {% end %}

    @non_nil_fields.delete("non_nil_fields")
  end

  # Type of the profile photo, must be "animated".
  property type : String

  # The animated profile photo. Profile photos can't be reused and can only be uploaded as a new file, so you can pass `attach://<file_attach_name>` if the photo was uploaded using `multipart/form-data` under `<file_attach_name>`.
  property animation : String

  # Timestamp in seconds of the frame that will be used as the static profile photo. Defaults to 0.0.
  property main_frame_timestamp : Float32 | Nil
end

# This object describes a profile photo to set.
alias Hamilton::Types::InputProfilePhoto = Hamilton::Types::InputProfilePhotoStatic | Hamilton::Types::InputProfilePhotoAnimated