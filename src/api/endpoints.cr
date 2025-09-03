class Hamilton::Api
  # :nodoc:
  ENDPOINTS = {
    "getUpdates" => {
      return_type: Array(Hamilton::Types::Update),
      docs: [%<Use this method to receive incoming updates using long polling. Returns an Array of Update objects.>, %<NOTE: This method will not work if an outgoing webhook is set up.>, %<NOTE: In order to avoid getting duplicate updates, recalculate offset after each server response.>],
      params: {
        :offset => {
          type: Int32 | Nil,
          docs: [%<Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as `getUpdates` is called with an offset higher than its `update_id`. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will be forgotten.>]
          },
        :limit => {
          type: Int32 | Nil,
          docs: [%<Limits the number of updates to be retrieved. Values between 1-100 are accepted. Defaults to 100.>]
        },
        :timeout => {
          type: Int32 | Nil,
          docs: [%<Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.>]
        },
        :allowed_updates => {
          type: Array(String) | Nil,
          docs: [%<A JSON-serialized list of the update types you want your bot to receive. For example, specify ["message", "edited_channel_post", "callback_query"] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all update types except `chat_member`, `message_reaction`, and `message_reaction_count` (default). If not specified, the previous setting will be used.>, %<Please note that this parameter doesn't affect updates created before the call to getUpdates, so unwanted updates may be received for a short period of time.>]
        }
      }
    },
    "setWebhook" => {
      type: Hamilton::Types::Update,
      docs: [%<Use this method to specify a URL and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified URL, containing a JSON-serialized Update. In case of an unsuccessful request (a request with response HTTP status code different from `2XY`), we will repeat the request and give up after a reasonable amount of attempts. Returns True on success.>, %<If you'd like to make sure that the webhook was set by you, you can specify secret data in the parameter secret_token. If specified, the request will contain a header “X-Telegram-Bot-Api-Secret-Token” with the secret token as content.>, %<NOTE: You will not be able to receive updates using `getUpdates` for as long as an outgoing webhook is set up.>, %<To use a self-signed certificate, you need to upload your public key certificate using `certificate` parameter. Please upload as `InputFile`, sending a String will not work.>, %<Ports currently supported for webhooks: 443, 80, 88, 8443.>, %<If you're having any trouble setting up webhooks, please check out this [amazing guide to webhooks](https://core.telegram.org/bots/webhooks).>],
      params: {
        :url => {
          type: String,
          docs: [%<HTTPS URL to send updates to. Use an empty string to remove webhook integration>]
        },
        :certificate => {
          type: Hamilton::Types::InputFile | Nil,
          docs: [%<Upload your public key certificate so that the root certificate in use can be checked.>]
        },
        :ip_address => {
          type: String | Nil,
          docs: [%<The fixed IP address which will be used to send webhook requests instead of the IP address resolved through DNS>]
        },
        :max_connections => {
          type: Int32 | Nil,
          docs: [%<The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot's server, and higher values to increase your bot's throughput.>]
        },
        :allowed_updates => {
          type: Array(String) | Nil,
          docs: [%<A JSON-serialized list of the update types you want your bot to receive. For example, specify ["message", "edited_channel_post", "callback_query"] to only receive updates of these types. See `Update` for a complete list of available update types. Specify an empty list to receive all update types except chat_member, message_reaction, and message_reaction_count (default). If not specified, the previous setting will be used.>, %<Please note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.>]
        },
        :drop_pending_updates => {
          type: Bool | Nil,
          docs: [%<Pass True to drop all pending updates>]
        },
        :secret_token => {
          type: String | Nil,
          docs: [%<A secret token to be sent in a header “X-Telegram-Bot-Api-Secret-Token” in every webhook request, 1-256 characters. Only characters `A-Z`, `a-z`, `0-9`, `_`, and `-` are allowed. The header is useful to ensure that the request comes from a webhook set by you.>]
        }
      }
    },
    "deleteWebhook" => {
      type: Bool,
      docs: [%<Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success.>],
      params: {
        :drop_pending_updates => {
          type: Bool | Nil,
          docs: [%<Pass True to drop all pending updates>]
        }
      }
    },
    "getWebhookInfo" => {
      type: Hamilton::Types::WebhookInfo,
      docs: [%<Use this method to get current webhook status. Requires no parameters. On success, returns a WebhookInfo object. If the bot is using getUpdates, will return an object with the url field empty.>]
    },
    "getMe" => {
      type: Hamilton::Types::User,
      docs: [%<A simple method for testing your bot's authentication token. Requires no parameters. Returns basic information about the bot in form of a User object.>]
    },
    "logOut" => {
      type: Bool,
      docs: [%<Use this method to log out from the cloud Bot API server before launching the bot locally. You must log out the bot before running it locally, otherwise there is no guarantee that the bot will receive updates. After a successful call, you can immediately log in on a local server, but will not be able to log in back to the cloud Bot API server for 10 minutes. Returns True on success. Requires no parameters.>]
    },
    "close" => {
      type: Bool,
      docs: [%<Use this method to close the bot instance before moving it from one local server to another. You need to delete the webhook before calling this method to ensure that the bot isn't launched again after server restart. The method will return error 429 in the first 10 minutes after the bot is launched. Returns True on success. Requires no parameters.>]
    },
    "sendMessage" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send text messages. On success, the sent Message is returned.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent>]
        },
        :chat_id => {
          type: String | Int32,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :text => {
          type: String,
          docs: [%<Text of the message to be sent, 1-4096 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the message text.>]
        },
        :entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in message text, which can be specified instead of `parse_mode`.>]
        },
        :link_preview_options => {
          type: Hamilton::Types::LinkPreviewOptions,
          docs: [%<Link preview generation options for the message.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    },
    "forwardMessage" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to forward messages of any kind. Service messages and messages with protected content can't be forwarded. On success, the sent Message is returned.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be forwarded; required if the message is forwarded to a direct messages chat.>]
        },
        :from_chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the chat where the original message was sent (or channel username in the format `@channelusername`).>]
        },
        :video_start_timestamp => {
          type: Int32 | Nil,
          docs: [%<New start timestamp for the forwarded video in the message.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the forwarded message from forwarding and saving.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only.>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Message identifier in the chat specified in `from_chat_id`.>]
        }
      }
    },
    "forwardMessages" => {
      type: Array(Hamilton::Types::MessageId),
      docs: [%<Use this method to forward multiple messages of any kind. If some of the specified messages can't be found or forwarded, they are skipped. Service messages and messages with protected content can't be forwarded. Album grouping is kept for forwarded messages. On success, an array of `MessageId` of the sent messages is returned.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the messages will be forwarded; required if the messages are forwarded to a direct messages chat.>]
        },
        :from_chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the chat where the original messages were sent (or channel username in the format `@channelusername`).>]
        },
        :message_ids => {
          type: Array(Int32),
          docs: [%<A JSON-serialized list of 1-100 identifiers of messages in the chat `from_chat_id` to forward. The identifiers must be specified in a strictly increasing order.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the messages silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the forwarded messages from forwarding and saving.>]
        }
      }
    },
    "copyMessage" => {
      type: Hamilton::Types::MessageId,
      docs: [%<Use this method to copy messages of any kind. Service messages, paid media messages, giveaway messages, giveaway winners messages, and invoice messages can't be copied. A quiz poll can be copied only if the value of the field `correct_option_id` is known to the bot. The method is analogous to the method `forwardMessage`, but the copied message doesn't have a link to the original message. Returns the `MessageId` of the sent message on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :from_chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the chat where the original message was sent (or channel username in the format `@channelusername`).>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Message identifier in the chat specified in `from_chat_id`.>]
        },
        :video_start_timestamp => {
          type: Int32 | Nil,
          docs: [%<New start timestamp for the copied video in the message.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<New caption for media, 0-1024 characters after entities parsing. If not specified, the original caption is kept.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the new caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the new caption, which can be specified instead of `parse_mode`.>]
        },
        :show_caption_above_media => {
          type: Bool | Nil,
          docs: [%<Pass True, if the caption must be shown above the message media. Ignored if a new caption isn't specified.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    },
    "copyMessages" => {
      type: Array(Hamilton::Types::MessageId),
      docs: [%<Use this method to copy messages of any kind. If some of the specified messages can't be found or copied, they are skipped. Service messages, paid media messages, giveaway messages, giveaway winners messages, and invoice messages can't be copied. A quiz poll can be copied only if the value of the field `correct_option_id` is known to the bot. The method is analogous to the method `forwardMessages`, but the copied messages don't have a link to the original message. Album grouping is kept for copied messages. On success, an array of `MessageId` of the sent messages is returned.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the messages will be sent; required if the messages are sent to a direct messages chat.>]
        },
        :from_chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the chat where the original messages were sent (or channel username in the format `@channelusername`).>]
        },
        :message_ids => {
          type: Array(Int32),
          docs: [%<A JSON-serialized list of 1-100 identifiers of messages in the chat `from_chat_id` to copy. The identifiers must be specified in a strictly increasing order.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the messages silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent messages from forwarding and saving.>]
        },
        :remove_caption => {
          type: Bool | Nil,
          docs: [%<Pass True to copy the messages without their captions.>]
        }
      }
    },
    "sendPhoto" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send photos. On success, the sent Message is returned.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :photo => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Photo to send. Pass a `file_id` as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. The photo must be at most 10 MB in size. The photo's width and height must not exceed 10000 in total. Width and height ratio must be at most 20.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Photo caption (may also be used when resending photos by `file_id`), 0-1024 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the photo caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :show_caption_above_media => {
          type: Bool | Nil,
          docs: [%<Pass True, if the caption must be shown above the message media.>]
        },
        :has_spoiler => {
          type: Bool | Nil,
          docs: [%<Pass True if the photo needs to be covered with a spoiler animation.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    },
    "sendAudio" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format. On success, the sent `Message` is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.>, %<For sending voice messages, use the sendVoice method instead.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :audio => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Audio file to send. Pass a `file_id` as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Audio caption, 0-1024 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the audio caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :duration => {
          type: Int32 | Nil,
          docs: [%<Duration of the audio in seconds.>]
        },
        :performer => {
          type: String | Nil,
          docs: [%<Performer.>]
        },
        :title => {
          type: String | Nil,
          docs: [%<Track name.>]
        },
        :thumbnail => {
          type: Hamilton::Types::InputFile | Nil,
          docs: [%<Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    },
    "sendDocument" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send general files. On success, the sent `Message` is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String | Nil,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :document => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<File to send. Pass a `file_id` as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.>]
        },
        :thumbnail => {
          type: Hamilton::Types::InputFile | Nil,
          docs: [%<Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Document caption (may also be used when resending documents by `file_id`), 0-1024 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the document caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :disable_content_type_detection => {
          type: Bool | Nil,
          docs: [%<Disables automatic server-side content type detection for files uploaded using multipart/form-data.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool,
          docs: [%<Protects the contents of the message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    },
    "sendVideo" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send video files, Telegram clients support MPEG4 videos (other formats may be sent as `Document`). On success, the sent `Message` is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :video => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Video to send. Pass a `file_id` as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data.>]
        },
        :duration => {
          type: Int32 | Nil,
          docs: [%<Duration of sent video in seconds.>]
        },
        :width => {
          type: Int32 | Nil,
          docs: [%<Video width.>]
        },
        :height => {
          type: Int32 | Nil,
          docs: [%<Video height.>]
        },
        :thumbnail => {
          type: Hamilton::Types::InputFile | Nil,
          docs: [%<Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :cover => {
          type: Hamilton::Types::InputFile | String | Nil,
          docs: [%<Cover for the video in the message. Pass a `file_id` to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :start_timestamp => {
          type: Int32 | Nil,
          docs: [%<Start timestamp for the video in the message.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Video caption (may also be used when resending videos by `file_id`), 0-1024 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the video caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :show_caption_above_media => {
          type: Bool | Nil,
          docs: [%<Pass True, if the caption must be shown above the message media.>]
        },
        :has_spoiler => {
          type: Bool | Nil,
          docs: [%<Pass True, if the video needs to be covered with a spoiler animation.>]
        },
        :supports_streaming => {
          type: Bool | Nil,
          docs: [%<Pass True if the uploaded video is suitable for streaming.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :suggested_post_parameters => {
          type: Hamilton::Types::SuggestedPostParameters | Nil,
          docs: [%<A JSON-serialized object containing the parameters of the suggested post to send; for direct messages chats only. If the message is sent as a reply to another suggested post, then that suggested post is automatically declined.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Hamilton::Types::ReplyKeyboardMarkup | Hamilton::Types::ReplyKeyboardRemove | Hamilton::Types::ForceReply | Nil,
          docs: [%<Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user.>]
        }
      }
    }
  }
end
