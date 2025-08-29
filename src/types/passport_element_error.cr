require "json"

# Represents an issue in one of the data fields that was provided by the user. The error is considered resolved when the field's value changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorDataField
  include JSON::Serializable

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

  # Error source, must be "data".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Name of the data field which has the error.
  property field_name : String

  # Base64-encoded data hash.
  property data_hash : String

  # Error message.
  property message : String
end

# Represents an issue with the front side of a document. The error is considered resolved when the file with the front side of the document changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorFrontSide
  include JSON::Serializable

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

  # Error source, must be "front_side".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded hash of the file with the front side of the document.
  property file_hash : String

  # Error message.
  property message : String
end

# Represents an issue with the reverse side of a document. The error is considered resolved when the file with reverse side of the document changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorReverseSide
  include JSON::Serializable

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

  # Error source, must be "reverse_side".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded hash of the file with the reverse side of the document.
  property file_hash : String

  # Error message.
  property message : String
end

# Represents an issue with the selfie with a document. The error is considered resolved when the file with the selfie changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorSelfie
  include JSON::Serializable

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

  # Error source, must be "selfie".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded hash of the file with the selfie.
  property file_hash : String

  # Error message.
  property message : String
end

# Represents an issue with a document scan. The error is considered resolved when the file with the document scan changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorFile
  include JSON::Serializable

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

  # Error source, must be "file".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded file hash.
  property file_hash : String

  # Error message.
  property message : String
end

# Represents an issue with a list of scans. The error is considered resolved when the list of files containing the scans changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorFiles
  include JSON::Serializable

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

  # Error source, must be "files".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded file hashes.
  property file_hash : Array(String)

  # Error message.
  property message : String
end

# Represents an issue with one of the files that constitute the translation of a document. The error is considered resolved when the file changes.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorTranslationFile
  include JSON::Serializable

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

  # Error source, must be "translation_file".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded file hash.
  property file_hash : String

  # Error message.
  property message : String
end

# Represents an issue with the translated version of a document. The error is considered resolved when a file with the document translation change.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorTranslationFiles
  include JSON::Serializable

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

  # Error source, must be "translation_files".
  property source : String

  # The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”.
  property type : String

  # Base64-encoded file hashes.
  property file_hash : Array(String)

  # Error message.
  property message : String
end

# Represents an issue in an unspecified place. The error is considered resolved when new data is added.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::PassportElementErrorUnspecified
  include JSON::Serializable

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

  # Error source, must be "unspecified".
  property source : String

  # Type of element of the user's Telegram Passport which has the issue.
  property type : String

  # Base64-encoded element hash.
  property element_hash : String

  # Error message.
  property message : String
end

# This object represents an error in the Telegram Passport element which was submitted that should be resolved by the user.
alias Hamilton::Types::PassportElementError = Hamilton::Types::PassportElementErrorDataField | Hamilton::Types::PassportElementErrorFrontSide | Hamilton::Types::PassportElementErrorReverseSide | Hamilton::Types::PassportElementErrorSelfie | Hamilton::Types::PassportElementErrorFile | Hamilton::Types::PassportElementErrorFiles | Hamilton::Types::PassportElementErrorTranslationFile | Hamilton::Types::PassportElementErrorTranslationFiles | Hamilton::Types::PassportElementErrorUnspecified