require "json"
require "./utils.cr"

# Represents a photo to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputMediaPhoto
  include Hamilton::Types::Common

  # Type of the result, must be "photo".
  property type : String = "photo"

  # File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property media : String

  # Caption of the photo to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the photo caption.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Pass True if the photo needs to be covered with a spoiler animation.
  property has_spoiler : Bool | Nil
end

# Represents a video to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputMediaVideo
  include Hamilton::Types::Common

  # Type of the result, must be "video".
  property type : String = "video"

  # File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property media : String

  # Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using `multipart/form-data`. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass `attach://<file_attach_name>` if the thumbnail was uploaded using multipart/form-data under `<file_attach_name>`.
  property thumbnail : String | Nil

  # Cover for the video in the message. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using multipart/form-data under `<file_attach_name>` name.
  property cover : String | Nil

  # Start timestamp for the video in the message.
  property start_timestamp : Int32 | Nil

  # Caption of the video to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the video caption.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Video width.
  property width : Int32

  # Video height.
  property height : Int32

  # Video duration in seconds.
  property duration : Int32

  # Pass True if the uploaded video is suitable for streaming.
  property supports_streaming : Bool | Nil

  # Pass True if the photo needs to be covered with a spoiler animation.
  property has_spoiler : Bool | Nil
end

# Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputMediaAnimation
  include Hamilton::Types::Common

  # Type of the result, must be "animation".
  property type : String = "animation"

  # File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property media : String

  # Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using `multipart/form-data`. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass `attach://<file_attach_name>` if the thumbnail was uploaded using multipart/form-data under `<file_attach_name>`.
  property thumbnail : String | Nil

  # Caption of the animation to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the animation caption.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Pass True, if the caption must be shown above the message media.
  property show_caption_above_media : Bool | Nil

  # Animation width.
  property width : Int32

  # Animation height.
  property height : Int32

  # Animation duration in seconds.
  property duration : Int32

  # Pass True if the photo needs to be covered with a spoiler animation.
  property has_spoiler : Bool | Nil
end

# Represents an audio file to be treated as music to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputMediaAudio
  include Hamilton::Types::Common

  # Type of the result, must be "audio".
  property type : String = "audio"

  # File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property media : String

  # Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using `multipart/form-data`. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass `attach://<file_attach_name>` if the thumbnail was uploaded using multipart/form-data under `<file_attach_name>`.
  property thumbnail : String | Nil

  # Caption of the audio to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the audio caption.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil

  # Duration of the audio in seconds.
  property duration : Int32 | Nil

  # Performer of the audio.
  property performer : String | Nil

  # Title of the audio.
  property title : String | Nil
end

# Represents a general file to be sent.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputMediaDocument
  include Hamilton::Types::Common

  # Type of the result, must be "document".
  property type : String = "document"

  # File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property media : String

  # Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using `multipart/form-data`. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass `attach://<file_attach_name>` if the thumbnail was uploaded using multipart/form-data under `<file_attach_name>`.
  property thumbnail : String | Nil

  # Caption of the document to be sent, 0-1024 characters after entities parsing.
  property caption : String | Nil

  # Mode for parsing entities in the document caption.
  property parse_mode : String | Nil

  # List of special entities that appear in the caption, which can be specified instead of `parse_mode`.
  property caption_entities : Array(Hamilton::Types::MessageEntity) | Nil
  
  # Disables automatic server-side content type detection for files uploaded using `multipart/form-data`. Always True, if the document is sent as part of an album.
  property disable_content_type_detection : Bool | Nil
end

# This object represents the content of a media message to be sent.
alias Hamilton::Types::InputMedia = Hamilton::Types::InputMediaPhoto | Hamilton::Types::InputMediaVideo | Hamilton::Types::InputMediaAnimation | Hamilton::Types::InputMediaAudio | Hamilton::Types::InputMediaDocument