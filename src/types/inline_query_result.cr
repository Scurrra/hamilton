require "json"

# Represents a link to an article or web page.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultArticle
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

  # Type of the result, must be "article".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Title of the result.
  property title : String

  # Content of the message to be sent.
  property input_message_content : Hamilton::Types::InputMessageContent

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # URL of the result.
  property url : String | Nil

  # Short description of the result.
  property description : String | Nil

  # Url of the thumbnail for the result.
  property thumbnail_url : String | Nil

  # Thumbnail width.
  property thumbnail_width : Int32 | Nil

  # Thumbnail height.
  property thumbnail_height : Int32 | Nil
end

# Represents a link to a photo. By default, this photo will be sent by the user with optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultPhoto
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

  # Type of the result, must be "photo".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL of the photo. Photo must be in JPEG format. Photo size must not exceed 5MB.
  property photo_url : String

  # URL of the thumbnail for the photo.
  property thumbnail_url : String

  # Width of the photo.
  property photo_width : Int32 | Nil

  # Height of the photo.
  property photo_height : Int32 | Nil

  # Title for the result.
  property title : String | Nil

  # Short description of the result.
  property description : String | Nil

  # Caption of the photo to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the photo caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the photo.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user with optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the animation.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultGif
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

  # Type of the result, must be "gif".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL for the GIF file.
  property gif_url : String

  # Width of the GIF.
  property gif_width : Int32 | Nil

  # Height of the GIF.
  property gif_height : Int32 | Nil

  # Duration of the GIF in seconds.
  property gif_duration : Int32 | Nil

  # URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result.
  property thumbnail_url : String

  # MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”.
  property thumbnail_mime_type : String | Nil

  # Title for the result.
  property title : String | Nil

  # Caption of the GIF file to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the GIF animation.
  property input_message_content : Hamilton::Types::InputMessageContent
end

# Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4 file will be sent by the user with optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the animation.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultMpeg4Gif
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

  # Type of the result, must be "mpeg4_gif".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL for the MPEG4 file.
  property mpeg4_url : String

  # Video width.
  property mpeg4_width : Int32 | Nil

  # Video height.
  property mpeg4_height : Int32 | Nil

  # Video duration in seconds.
  property mpeg4_duration : Int32 | Nil

  # URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result.
  property thumbnail_url : String

  # MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”.
  property thumbnail_mime_type : String | Nil

  # Title for the result.
  property title : String | Nil

  # Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the video animation.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a page containing an embedded video player or a video file. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the video.
#
# NOTE: If an InlineQueryResultVideo message contains an embedded video (e.g., YouTube), you must replace its content using `input_message_content`.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultVideo
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

  # Type of the result, must be "video".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL for the embedded video player or video file.
  property video_url : String

  # MIME type of the content of the video URL, “text/html” or “video/mp4”.
  property mime_type : String

  # URL of the thumbnail (JPEG only) for the video.
  property thumbnail_url : String

  # Title for the result.
  property title : String

  # Caption of the video to be sent, 0-1024 characters after entities parsing.
  property caption : String

  # Mode for parsing entities in the video caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Video width.
  property video_width : Int32 | Nil

  # Video height.
  property video_height : Int32 | Nil

  # Video duration in seconds.
  property video_duration : Int32 | Nil

  # Short description of the result.
  property description : String | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to an MP3 audio file. By default, this audio file will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the audio.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultAudio
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

  # Type of the result, must be "audio".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL for the audio file.
  property audio_url : String

  # Title.
  property title : String

  # Caption, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the audio caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil
  
  # Performer.
  property performer : String | Nil

  # Audio duration in seconds.
  property audio_duration : Int32 | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the audio.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a voice recording in an .OGG container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the the voice message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultVoice
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

  # Type of the result, must be "voice".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid URL for the voice recording.
  property voice_url : String

  # Recording title.
  property title : String

  # Caption, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the voice message caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of parse_mode.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Recording duration in seconds.
  property voice_duration : Int32 | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the voice recording.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultDocument
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

  # Type of the result, must be "document".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Title for the result.
  property title : String

  # Caption of the document to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the document caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # A valid URL for the file.
  property document_url : String

  # MIME type of the content of the file, either “application/pdf” or “application/zip”.
  property mime_type : String

  # Short description of the result.
  property description : String | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the file.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil

  # URL of the thumbnail (JPEG only) for the file.
  property thumbnail_url : String | Nil

  # Thumbnail width.
  property thumbnail_width : Int32 | Nil

  # Thumbnail height.
  property thumbnail_height : Int32 | Nil
end

# Represents a location on a map. By default, the location will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the location.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultLocation
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

  # Type of the result, must be "location".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Location latitude in degrees.
  property latitude : Float32

  # Location longitude in degrees.
  property longitude : Float32

  # Location title.
  property title : String

  # The radius of uncertainty for the location, measured in meters; 0-1500.
  property horizontal_accuracy : Float32 | Nil

  # Period in seconds during which the location can be updated, should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.
  property live_period : Int32 | Nil

  # For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
  property heading : Int32 | Nil

  # For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
  property proximity_alert_radius : Int32 | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the location.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil

  # Url of the thumbnail for the result.
  property thumbnail_url : String | Nil

  # Thumbnail width.
  property thumbnail_width : Int32 | Nil

  # Thumbnail height.
  property thumbnail_height : Int32 | Nil
end

# Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the venue.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultVenue
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

  # Type of the result, must be "venue".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Latitude of the venue location in degrees.
  property latitude : Float32

  # Longitude of the venue location in degrees.
  property longitude : Float32

  # Title of the venue.
  property title : String

  # Address of the venue.
  property address : String

  # Foursquare identifier of the venue if known.
  property foursquare_id : String | Nil

  # Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
  property foursquare_type : String | Nil

  # Google Places identifier of the venue.
  property google_place_id : String | Nil

  # Google Places type of the venue.
  property google_place_type : String | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the venue.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil

  # Url of the thumbnail for the result.
  property thumbnail_url : String | Nil

  # Thumbnail width.
  property thumbnail_width : Int32 | Nil

  # Thumbnail height.
  property thumbnail_height : Int32 | Nil
end

# Represents a contact with a phone number. By default, this contact will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the contact.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultContact
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

  # Type of the result, must be "contact".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Contact's phone number.
  property phone_number : String

  # Contact's first name.
  property first_name : String

  # Contact's last name.
  property last_name : String | Nil

  # Additional data about the contact in the form of a vCard, 0-2048 bytes.
  property vcard : String | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the contact.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil

  # Url of the thumbnail for the result.
  property thumbnail_url : String | Nil

  # Thumbnail width.
  property thumbnail_width : Int32 | Nil

  # Thumbnail height.
  property thumbnail_height : Int32 | Nil
end

# Represents a Game.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultGame
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

  # Type of the result, must be "game".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Short name of the game.
  property game_short_name : String

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil
end

# Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedPhoto
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

  # Type of the result, must be "photo".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier of the photo.
  property photo_file_id : String

  # Title for the result.
  property title : String | Nil

  # Short description of the result.
  property description : String | Nil

  # Caption of the photo to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the photo caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the photo.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to an animated GIF file stored on the Telegram servers. By default, this animated GIF file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with specified content instead of the animation.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedGif
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

  # Type of the result, must be "gif".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier for the GIF file.
  property gif_file_id : String
  
  # Title for the result.
  property title : String | Nil

  # Caption of the GIF file to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the GIF animation.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the animation.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedMpeg4Gif
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

  # Type of the result, must be "mpeg4_gif".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier for the MPEG4 file.
  property mpeg4_file_id : String

  # Title for the result.
  property title : String | Nil

  # Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the video animation.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a sticker stored on the Telegram servers. By default, this sticker will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the sticker.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedSticker
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

  # Type of the result, must be "sticker".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier of the sticker.
  property sticker_file_id : String

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the sticker.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the file.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedDocument
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

  # Type of the result, must be "document".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # Title for the result.
  property title : String

  # A valid file identifier for the file.
  property document_file_id : String

  # Short description of the result
  property description : String | Nil

  # Caption of the document to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the document caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the file.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a video file stored on the Telegram servers. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the video.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedVideo
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

  # Type of the result, must be "video".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier for the video file.
  property video_file_id : String

  # Title for the result.
  property title : String

  # Short description of the result.
  property description : String | Nil

  # Caption of the video to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the video caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the video.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to a voice message stored on the Telegram servers. By default, this voice message will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the voice message.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedVoice
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

  # Type of the result, must be "voice".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier for the voice message.
  property voice_file_id : String

  # Voice message title.
  property title : String

  # Caption, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the voice message caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the voice message.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# Represents a link to an MP3 audio file stored on the Telegram servers. By default, this audio file will be sent by the user. Alternatively, you can use `input_message_content` to send a message with the specified content instead of the audio.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InlineQueryResultCachedAudio
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

  # Type of the result, must be "audio".
  property type : String

  # Unique identifier for this result, 1-64 Bytes.
  property id : String

  # A valid file identifier for the audio file.
  property audio_file_id : String

  # Caption, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the audio caption. See formatting options for more details.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Inline keyboard attached to the message.
  property reply_markup : Hamilton::Types::InlineKeyboardMarkup | Nil

  # Content of the message to be sent instead of the audio.
  property input_message_content : Hamilton::Types::InputMessageContent | Nil
end

# This object represents one result of an inline query.
#
# NOTE: All URLs passed in inline query results will be available to end users and therefore must be assumed to be public.
alias Hamilton::Types::InlineQueryResult = Hamilton::Types::InlineQueryResultArticle | Hamilton::Types::InlineQueryResultPhoto | Hamilton::Types::InlineQueryResultGif | Hamilton::Types::InlineQueryResultMpeg4Gif | Hamilton::Types::InlineQueryResultVideo | Hamilton::Types::InlineQueryResultAudio | Hamilton::Types::InlineQueryResultVoice | Hamilton::Types::InlineQueryResultDocument | Hamilton::Types::InlineQueryResultLocation | Hamilton::Types::InlineQueryResultVenue | Hamilton::Types::InlineQueryResultContact | Hamilton::Types::InlineQueryResultGame | Hamilton::Types::InlineQueryResultCachedPhoto | Hamilton::Types::InlineQueryResultCachedGif | Hamilton::Types::InlineQueryResultCachedMpeg4Gif | Hamilton::Types::InlineQueryResultCachedSticker | Hamilton::Types::InlineQueryResultCachedDocument | Hamilton::Types::InlineQueryResultCachedVideo | Hamilton::Types::InlineQueryResultCachedVoice | Hamilton::Types::InlineQueryResultCachedAudio