require "json"

# This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.
@[JSON::Serializable::Options(emit_nulls: true)]
class Hamilton::Types::MessageEntity
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

  # Type of the entity. Currently, can be “mention” (`@username`), “hashtag” (`#hashtag` or `#hashtag@chatusername`), “cashtag” (`$USD` or `$USD@chatusername`), “bot_command” (`/start@jobs_bot`), “url” (`https://telegram.org`), “email” (`do-not-reply@telegram.org`), “phone_number” (`+1-212-555-0123`), “bold” (**bold text**), “italic” (*italic text*), “underline” (underlined text), “strikethrough” (strikethrough text), “spoiler” (spoiler message), “blockquote” (block quotation), “expandable_blockquote” (collapsed-by-default block quotation), “code” (monowidth string), “pre” (monowidth block), “text_link” (for clickable text URLs), “text_mention” (for users without usernames), “custom_emoji” (for inline custom emoji stickers)
  property type : String

  # Offset in UTF-16 code units to the start of the entity.
  property offset : Int32

  # Length of the entity in UTF-16 code units.
  property length : Int32

  # For “text_link” only, URL that will be opened after user taps on the text.
  property url : String | Nil

  # For “text_mention” only, the mentioned user.
  property user : Hamilton::Types::User | Nil

  # For “pre” only, the programming language of the entity text.
  property language : String | Nil

  # For “custom_emoji” only, unique identifier of the custom emoji.
  property custom_emoji_id : String | Nil
end