require "json"
require "./utils.cr"

# The paid media to send is a photo.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputPaidMediaPhoto
  include Hamilton::Types::Common

  # Type of the media, must be "photo".
  property type : String = "photo"

  # File to send. Pass a `file_id` to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using multipart/form-data under `<file_attach_name>` name.
  property media : String
end

# The paid media to send is a video.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::InputPaidMediaVideo
  include Hamilton::Types::Common

  # Type of the media, must be "video".
  property type : String = "video"

  # File to send. Pass a `file_id` to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using multipart/form-data under `<file_attach_name>` name.
  property media : String

  # Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using `multipart/form-data`. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass `attach://<file_attach_name>` if the thumbnail was uploaded using multipart/form-data under `<file_attach_name>`.
  property thumbnail : String | Nil

  # Cover for the video in the message. Pass a `file_id` to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass `attach://<file_attach_name>` to upload a new one using `multipart/form-data` under `<file_attach_name>` name.
  property cover : String | Nil

  # Start timestamp for the video in the message.
  property start_timestamp : Int32 | Nil

  # Video width.
  property width : Int32 | Nil

  # Video height.
  property height : Int32 | Nil

  # Video duration in seconds.
  property duration : Int32 | Nil

  # Pass True if the uploaded video is suitable for streaming.
  property supports_streaming : Bool | Nil
end

# This object describes the paid media to be sent.
alias Hamilton::Types::InputPaidMedia = Hamilton::Types::InputPaidMediaPhoto | Hamilton::Types::InputPaidMediaVideo