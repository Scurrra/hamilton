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
    },
    "sendAnimation" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent `Message` is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.>],
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
        :animation => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :duration => {
          type: Int32 | Nil,
          docs: [%<Duration of sent animation in seconds.>]
        },
        :width => {
          type: Int32 | Nil,
          docs: [%<Animation width.>]
        },
        :height => {
          type: Int32 | Nil,
          docs: [%<Animation height.>]
        },
        :thumbnail => {
          type: Hamilton::Types::InputFile | String | Nil,
          docs: [%<Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Animation caption (may also be used when resending animation by `file_id), 0-1024 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the animation caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode.>]
        },
        :show_caption_above_media => {
          type: Bool | Nil,
          docs: [%<Pass True, if the caption must be shown above the message media.>]
        },
        :has_spoiler => {
          type: Bool | Nil,
          docs: [%<Pass True if the animation needs to be covered with a spoiler animation.>]
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
    "sendVoice" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS, or in .MP3 format, or in .M4A format (other formats may be sent as `Audio` or `Document`). On success, the sent `Message` is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.>],
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
        :voice => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Voice message caption, 0-1024 characters after entities parsing.>]
        },
        :parse_mode	 => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the voice message caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :duration => {
          type: Int32 | Nil,
          docs: [%<Duration of the voice message in seconds.>]
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
    "sendVideoNote" => {
      type: Hamilton::Types::Message,
      docs: [%<As of v.4.0, Telegram clients support rounded square MPEG4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent `Message` is returned.>],
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
        :video_note => {
          type: Hamilton::Types::InputFile | String,
          docs: [%<Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More information on Sending Files ». Sending video notes by a URL is currently unsupported.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
        },
        :duration => {
          type: Int32 | Nil,
          docs: [%<Duration of sent video in seconds.>]
        },
        :length => {
          type: Int32 | Nil,
          docs: [%<Video width and height, i.e. diameter of the video message.>]
        },
        :thumbnail => {
          type: Hamilton::Types::InputFile | String | Nil,
          docs: [%<Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>.>, %<NOTE: Hamilton sends files for you, just pass an instance of  `Hamilton::Types::InputFile` with file and filename fields.>]
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
    "sendPaidMedia" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send paid media. On success, the sent `Message` is returned.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`). If the chat is a channel, all Telegram Star proceeds from this media will be credited to the chat's balance. Otherwise, they will be credited to the bot's balance.>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only>]
        },
        :direct_messages_topic_id => {
          type: Int32 | Nil,
          docs: [%<Identifier of the direct messages topic to which the message will be sent; required if the message is sent to a direct messages chat.>]
        },
        :star_count => {
          type: Int32,
          docs: [%<The number of Telegram Stars that must be paid to buy access to the media; 1-10000>]
        },
        :media => {
          type: Array(Hamilton::Types::InputPaidMedia),
          docs: [%<A JSON-serialized array describing the media to be sent; up to 10 items.>]
        },
        :payload => {
          type: String | Nil,
          docs: [%<Bot-defined paid media payload, 0-128 bytes. This will not be displayed to the user, use it for your internal processes.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Media caption, 0-1024 characters after entities parsing>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the media caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :show_caption_above_media => {
          type: Bool | Nil,
          docs: [%<Pass True, if the caption must be shown above the message media.>]
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
    "sendMediaGroup" => {
      type: Array(Hamilton::Types::Message),
      docs: [%<Use this method to send a group of photos, videos, documents or audios as an album. Documents and audio files can be only grouped in an album with messages of the same type. On success, an array of `Message` objects that were sent is returned.>],
      params: {
        :business_connection_id => {
          type: String |Nil,
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
          docs: [%<Identifier of the direct messages topic to which the messages will be sent; required if the messages are sent to a direct messages chat.>]
        },
        :media => {
          type: Array(Hamilton::Types::InputMediaAudio | Hamilton::Types::InputMediaDocument | Hamilton::Types::InputMediaPhoto | Hamilton::Types::InputMediaVideo),
          docs: [%<A JSON-serialized array describing messages to be sent, must include 2-10 items.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends messages silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent messages from forwarding and saving.>]
        },
        :allow_paid_broadcast => {
          type: Bool | Nil,
          docs: [%<Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<Description of the message to reply to.>]
        }
      }
    },
    "sendLocation" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send point on the map. On success, the sent Message is returned.>],
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
        :latitude => {
          type: Float32,
          docs: [%<Latitude of the location.>]
        },
        :longitude => {
          type: Float32,
          docs: [%<Longitude of the location.>]
        },
        :horizontal_accuracy => {
          type: Float32 | Nil,
          docs: [%<The radius of uncertainty for the location, measured in meters; 0-1500.>]
        },
        :live_period => {
          type: Int32 | Nil,
          docs: [%<Period in seconds during which the location will be updated (should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.>]
        },
        :heading => {
          type: Int32 | Nil,
          docs: [%<For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.>]
        },
        :proximity_alert_radius => {
          type: Int32 | Nil,
          docs: [%<For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.>]
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
    "sendVenue" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send information about a venue. On success, the sent `Message` is returned.>],
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
        :latitude => {
          type: Float32,
          docs: [%<Latitude of the venue.>]
        },
        :longitude => {
          type: Float32,
          docs: [%<Longitude of the venue.>]
        },
        :title => {
          type: String,
          docs: [%<Name of the venue.>]
        },
        :address => {
          type: String,
          docs: [%<Address of the venue.>]
        },
        :foursquare_id => {
          type: String | Nil,
          docs: [%<Foursquare identifier of the venue.>]
        },
        :foursquare_type => {
          type: String | Nil,
          docs: [%<Foursquare type of the venue, if known.>]
        },
        :google_place_id => {
          type: String | Nil,
          docs: [%<Google Places identifier of the venue.>]
        },
        :google_place_type => {
          type: String | Nil,
          docs: [%<Google Places type of the venue.>]
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
    "sendContact" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send phone contacts. On success, the sent Message is returned.>],
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
        :phone_number => {
          type: String,
          docs: [%<Contact's phone number.>]
        },
        :first_name => {
          type: String,
          docs: [%<Contact's first name.>]
        },
        :last_name => {
          type: String | Nil,
          docs: [%<Contact's last name.>]
        },
        :vcard => {
          type: String | Nil,
          docs: [%<Additional data about the contact in the form of a vCard, 0-2048 bytes.>]
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
    "sendPoll" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send a native poll. On success, the sent Message is returned.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`). Polls can't be sent to channel direct messages chats.>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.>]
        },
        :question => {
          type: String,
          docs: [%<Poll question, 1-300 characters.>]
        },
        :question_parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the question. Currently, only custom emoji entities are allowed.>]
        },
        :question_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the poll question. It can be specified instead of `question_parse_mode`.>]
        },
        :options => {
          type: Array(Hamilton::Types::InputPollOption),
          docs: [%<A JSON-serialized list of 2-12 answer options.>]
        },
        :is_anonymous => {
          type: Bool | Nil,
          docs: [%<True, if the poll needs to be anonymous, defaults to True.>]
        },
        :type => {
          type: String | Nil,
          docs: [%<Poll type, “quiz” or “regular”, defaults to “regular”.>]
        },
        :allows_multiple_answers => {
          type: Bool | Nil,
          docs: [%<True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False.>]
        },
        :correct_option_id => {
          type: Int32 | Nil,
          docs: [%<0-based identifier of the correct answer option, required for polls in quiz mode.>]
        },
        :explanation => {
          type: String | Nil,
          docs: [%<Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing.>]
        },
        :explanation_parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the explanation. See formatting options for more details.>]
        },
        :explanation_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the poll explanation. It can be specified instead of `explanation_parse_mode`.>]
        },
        :open_period => {
          type: Int32 | Nil,
          docs: [%<Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with `close_date`.>]
        },
        :close_date => {
          type: Int32 | Nil,
          docs: [%<Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with `open_period`.>]
        },
        :is_closed => {
          type: Bool | Nil,
          docs: [%<Pass True if the poll needs to be immediately closed. This can be useful for poll preview.>]
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
          type: Int32 | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message; for private chats only.>]
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
    "sendChecklist" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send a checklist on behalf of a connected business account. On success, the sent Message is returned.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be sent.>]
        },
        :chat_id => {
          type: Int32,
          docs: [%<Unique identifier for the target chat.>]
        },
        :checklist => {
          type: Hamilton::Types::InputChecklist,
          docs: [%<A JSON-serialized object for the checklist to send.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding and saving.>]
        },
        :message_effect_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the message effect to be added to the message.>]
        },
        :reply_parameters => {
          type: Hamilton::Types::ReplyParameters | Nil,
          docs: [%<A JSON-serialized object for description of the message to reply to.>]
        },
        :reply_markup => {
          type: Hamilton::Types::InlineKeyboardMarkup | Nil,
          docs: [%<A JSON-serialized object for an inline keyboard.>]
        }
      }
    },
    "sendDice" => {
      type: Hamilton::Types::Message,
      docs: [%<Use this method to send an animated emoji that will display a random value. On success, the sent Message is returned.>],
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
        :emoji => {
          type: String | Nil,
          docs: [%<Emoji on which the dice throw animation is based. Currently, must be one of “🎲”, “🎯”, “🏀”, “⚽”, “🎳”, or “🎰”. Dice can have values 1-6 for “🎲”, “🎯” and “🎳”, values 1-5 for “🏀” and “⚽”, and values 1-64 for “🎰”. Defaults to “🎲”.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Sends the message silently. Users will receive a notification with no sound.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Protects the contents of the sent message from forwarding.>]
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
    "sendChatAction" => {
      type: Bool,
      docs: [%<Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.>, %<We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the action will be sent.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername). Channel chats and channel direct messages chats aren't supported.>]
        },
        :message_thread_id => {
          type: Int32 | Nil,
          docs: [%<Unique identifier for the target message thread; for supergroups only.>]
        },
        :action => {
          type: String,
          docs: [%<Type of action to broadcast. Choose one, depending on what the user is about to receive: "typing" for text messages, "upload_photo" for photos, "record_video" or "upload_video" for videos, "record_voice" or "upload_voice" for voice notes, "upload_document" for general files, "choose_sticker" for stickers, "find_location" for location data, "record_video_note" or "upload_video_note" for video notes.>]
        }
      }
    },
    "setMessageReaction" => {
      type: Bool,
      docs: [%<Use this method to change the chosen reactions on a message. Service messages of some types can't be reacted to. Automatically forwarded messages from a channel to its discussion group have the same available reactions as messages in the channel. Bots can't use paid reactions. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Identifier of the target message. If the message belongs to a media group, the reaction is set to the first non-deleted message in the group instead.>]
        },
        :reaction => {
          type: Array(Hamilton::Types::ReactionType) | Nil,
          docs: [%<A JSON-serialized list of reaction types to set on the message. Currently, as non-premium users, bots can set up to one reaction per message. A custom emoji reaction can be used if it is either already present on the message or explicitly allowed by chat administrators. Paid reactions can't be used by bots.>]
        },
        :is_big => {
          type: Bool | Nil,
          docs: [%<Pass True to set the reaction with a big animation.>]
        }
      }
    },
    "getUserProfilePhotos" => {
      type: Hamilton::Types::UserProfilePhotos,
      docs: [%<Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.>],
      params: {
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :offset => {
          type: Int32 | Nil,
          docs: [%<Sequential number of the first photo to be returned. By default, all photos are returned.>]
        },
        :limit => {
          type: Int32 | Nil,
          docs: [%<Limits the number of photos to be retrieved. Values between 1-100 are accepted. Defaults to 100.>]
        }
      }
    },
    "setUserEmojiStatus" => {
      type: Bool,
      docs: [%<Changes the emoji status for a given user that previously allowed the bot to manage their emoji status via the Mini App method `requestEmojiStatusAccess`. Returns True on success.>],
      params: {
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :emoji_status_custom_emoji_id => {
          type: String | Nil,
          docs: [%<Custom emoji identifier of the emoji status to set. Pass an empty string to remove the status.>]
        },
        :emoji_status_expiration_date => {
          type: Int32 | Nil,
          docs: [%<Expiration date of the emoji status, if any.>]
        }
      }
    },
    "getFile" => {
      type: Hamilton::Types::File,
      docs: [%<Use this method to get basic information about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling `getFile` again.>, %<NOTE: This function may not preserve the original file name and MIME type. You should save the file's MIME type and name (if available) when the File object is received.>],
      params: {
        :file_id => {
          type: String,
          docs: [%<File identifier to get information about.>]
        }
      }
    },
    "banChatMember" => {
      type: Bool,
      docs: [%<Use this method to ban a user in a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the chat on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target group or username of the target supergroup or channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :until_date => {
          type: Int32 | Nil,
          docs: [%<Date when the user will be unbanned; Unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever. Applied for supergroups and channels only.>]
        },
        :revoke_messages => {
          type: Bool | Nil,
          docs: [%<Pass True to delete all messages from the chat for the user that is being removed. If False, the user will be able to see messages in the group that were sent before the user was removed. Always True for supergroups and channels.>]
        }
      }
    },
    "unbanChatMember" => {
      type: Bool,
      docs: [%<Use this method to unban a previously banned user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. By default, this method guarantees that after the call the user is not a member of the chat, but will be able to join it. So if the user is a member of the chat they will also be removed from the chat. If you don't want this, use the parameter `only_if_banned`. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target group or username of the target supergroup or channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :only_if_banned => {
          type: Bool | Nil,
          docs: [%<Do nothing if the user is not banned.>]
        }
      }
    },
    "restrictChatMember" => {
      type: Bool,
      docs: [%<Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate administrator rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :permissions => {
          type: Hamilton::Types::ChatPermissions,
          docs: [%<A JSON-serialized object for new user permissions.>]
        },
        :use_independent_chat_permissions => {
          type: Bool | Nil,
          docs: [%<Pass True if chat permissions are set independently. Otherwise, the "can_send_other_messages" and "can_add_web_page_previews" permissions will imply the "can_send_messages", "can_send_audios", "can_send_documents", "can_send_photos", "can_send_videos", "can_send_video_notes", and "can_send_voice_notes" permissions; the "can_send_polls" permission will imply the "can_send_messages" permission.>]
        },
        :until_date => {
          type: Int32 | Nil,
          docs: [%<Date when restrictions will be lifted for the user; Unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever.>]
        }
      }
    },
    "promoteChatMember" => {
      type: Bool,
      docs: [%<Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Pass False for all boolean parameters to demote a user. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :is_anonymous => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator's presence in the chat is hidden.>]
        },
        :can_manage_chat => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages, ignore slow mode, and send messages to the chat without paying Telegram Stars. Implied by any other administrator privilege.>]
        },
        :can_delete_messages => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can delete messages of other users.>]
        },
        :can_manage_video_chats => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can manage video chats.>]
        },
        :can_restrict_members => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can restrict, ban or unban chat members, or access supergroup statistics.>]
        },
        :can_promote_members => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by him).>]
        },
        :can_change_info => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can change chat title, photo and other settings.>]
        },
        :can_invite_users => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can invite new users to the chat.>]
        },
        :can_post_stories => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can post stories to the chat.>]
        },
        :can_edit_stories => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive.>]
        },
        :can_delete_stories => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can delete stories posted by other users.>]
        },
        :can_post_messages => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can post messages in the channel, approve suggested posts, or access channel statistics; for channels only.>]
        },
        :can_edit_messages => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can edit messages of other users and can pin messages; for channels only.>]
        },
        :can_pin_messages => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can pin messages; for supergroups only.>]
        },
        :can_manage_topics => {
          type: Bool | Nil,
          docs: [%<Pass True if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only.>]
        },
        :can_manage_direct_messages => {
          type: Bool | Nil,
          docs: [%<Pass True if the administrator can manage direct messages within the channel and decline suggested posts; for channels only.>]
        }
      }
    },
    "setChatAdministratorCustomTitle" => {
      type: Bool,
      docs: [%<Use this method to set a custom title for an administrator in a supergroup promoted by the bot. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :custom_title => {
          type: String,
          docs: [%<New custom title for the administrator; 0-16 characters, emoji are not allowed.>]
        }
      }
    },
    "banChatSenderChat" => {
      type: Bool,
      docs: [%<Use this method to ban a channel chat in a supergroup or a channel. Until the chat is unbanned, the owner of the banned chat won't be able to send messages on behalf of any of their channels. The bot must be an administrator in the supergroup or channel for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :sender_chat_id => {
          type: Int32,
          docs: [%<Unique identifier of the target sender chat.>]
        }
      }
    },
    "unbanChatSenderChat" => {
      type: Bool,
      docs: [%<Use this method to unban a previously banned channel chat in a supergroup or channel. The bot must be an administrator for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :sender_chat_id => {
          type: Int32,
          docs: [%<Unique identifier of the target sender chat.>]
        }
      }
    },
    "setChatPermissions" => {
      type: Bool,
      docs: [%<Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the `can_restrict_members` administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`).>]
        },
        :permissions => {
          type: Hamilton::Types::ChatPermissions,
          docs: [%<A JSON-serialized object for new default chat permissions.>]
        },
        :use_independent_chat_permissions => {
          type: Bool | Nil,
          docs: [%<Pass True if chat permissions are set independently. Otherwise, the "can_send_other_messages" and "can_add_web_page_previews" permissions will imply the "can_send_messages", "can_send_audios", "can_send_documents", "can_send_photos", "can_send_videos", "can_send_video_notes", and "can_send_voice_notes" permissions; the "can_send_polls" permission will imply the "can_send_messages" permission.>]
        }
      }
    },
    "exportChatInviteLink" => {
      type: String,
      docs: [%<Use this method to generate a new primary invite link for a chat; any previously generated primary link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the new invite link as String on success.>, %<NOTE: Each administrator in a chat generates their own invite links. Bots can't use invite links generated by other administrators. If you want your bot to work with invite links, it will need to generate its own link using `exportChatInviteLink` or by calling the `getChat` method. If your bot needs to generate a new primary invite link replacing its previous one, use `exportChatInviteLink` again.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@supergroupusername`).>]
        }
      }
    },
    "createChatInviteLink" => {
      type: Hamilton::Types::ChatInviteLink,
      docs: [%<Use this method to create an additional invite link for a chat. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. The link can be revoked using the method `revokeChatInviteLink`. Returns the new invite link as `ChatInviteLink` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :name => {
          type: String | Nil,
          docs: [%<Invite link name; 0-32 characters.>]
        },
        :expire_date => {
          type: Int32 | Nil,
          docs: [%<Point in time (Unix timestamp) when the link will expire.>]
        },
        :member_limit => {
          type: Int32 | Nil,
          docs: [%<The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999.>]
        },
        :creates_join_request => {
          type: Bool | Nil,
          docs: [%<True, if users joining the chat via the link need to be approved by chat administrators. If True, `member_limit` can't be specified.>]
        }
      }
    },
    "editChatInviteLink" => {
      type: Hamilton::Types::ChatInviteLink,
      docs: [%<Use this method to edit a non-primary invite link created by the bot. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the edited invite link as a `ChatInviteLink` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :invite_link => {
          type: String,
          docs: [%<The invite link to edit.>]
        },
        :name => {
          type: String | Nil,
          docs: [%<Invite link name; 0-32 characters.>]
        },
        :expire_date => {
          type: Int32 | Nil,
          docs: [%<Point in time (Unix timestamp) when the link will expire.>]
        },
        :member_limit => {
          type: Int32 | Nil,
          docs: [%<The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999.>]
        },
        :creates_join_request => {
          type: Bool | Nil,
          docs: [%<True, if users joining the chat via the link need to be approved by chat administrators. If True, `member_limit` can't be specified.>]
        }
      }
    },
    "createChatSubscriptionInviteLink" => {
      type: Hamilton::Types::ChatInviteLink,
      docs: [%<Use this method to create a subscription invite link for a channel chat. The bot must have the "can_invite_users" administrator rights. The link can be edited using the method `editChatSubscriptionInviteLink` or revoked using the method `revokeChatInviteLink`. Returns the new invite link as a `ChatInviteLink` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :name => {
          type: String | Nil,
          docs: [%<Invite link name; 0-32 characters.>]
        },
        :subscription_period => {
          type: Int32,
          docs: [%<The number of seconds the subscription will be active for before the next payment. Currently, it must always be 2592000 (30 days).>]
        },
        :subscription_price => {
          type: Int32,
          docs: [%<The amount of Telegram Stars a user must pay initially and after each subsequent subscription period to be a member of the chat; 1-10000.>]
        }
      }
    },
    "editChatSubscriptionInviteLink" => {
      type: Hamilton::Types::ChatInviteLink,
      docs: [%<Use this method to edit a subscription invite link created by the bot. The bot must have the "can_invite_users" administrator rights. Returns the edited invite link as a `ChatInviteLink` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :invite_link => {
          type: String,
          docs: [%<The invite link to edit.>]
        },
        :name => {
          type: String | Nil,
          docs: [%<Invite link name; 0-32 characters.>]
        }
      }
    },
    "revokeChatInviteLink" => {
      type: Hamilton::Types::ChatInviteLink,
      docs: [%<Use this method to revoke an invite link created by the bot. If the primary link is revoked, a new link is automatically generated. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the revoked invite link as `ChatInviteLink` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :invite_link => {
          type: String,
          docs: [%<The invite link to revoke.>]
        }
      }
    },
    "approveChatJoinRequest" => {
      type: Bool,
      docs: [%<Use this method to approve a chat join request. The bot must be an administrator in the chat for this to work and must have the "can_invite_users" administrator right. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        }
      }
    },
    "declineChatJoinRequest" => {
      type: Bool,
      docs: [%<Use this method to decline a chat join request. The bot must be an administrator in the chat for this to work and must have the "can_invite_users" administrator right. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        }
      }
    },
    "setChatPhoto" => {
      type: Bool,
      docs: [%<Use this method to set a new profile photo for the chat. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :photo => {
          type: InputFile,
          docs: [%<New chat photo, uploaded using multipart/form-data.>]
        }
      }
    },
    "deleteChatPhoto" => {
      type: Bool,
      docs: [%<Use this method to delete a chat photo. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        }
      }
    },
    "setChatTitle" => {
      type: Bool,
      docs: [%<Use this method to change the title of a chat. Titles can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :title => {
          type: String,
          docs: [%<New chat title, 1-128 characters.>]
        }
      }
    },
    "setChatDescription" => {
      type: Bool,
      docs: [%<Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :description => {
          type: String,
          docs: [%<New chat description, 0-255 characters.>]
        }
      }
    },
    "pinChatMessage" => {
      type: Bool,
      docs: [%<Use this method to add a message to the list of pinned messages in a chat. In private chats and channel direct messages chats, all non-service messages can be pinned. Conversely, the bot must be an administrator with the "can_pin_messages" right or the "can_edit_messages" right to pin messages in groups and channels respectively. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be pinned.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Identifier of a message to pin.>]
        },
        :disable_notification => {
          type: Bool | Nil,
          docs: [%<Pass True if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels and private chats.>]
        }
      }
    },
    "unpinChatMessage" => {
      type: Bool,
      docs: [%<Use this method to remove a message from the list of pinned messages in a chat. In private chats and channel direct messages chats, all messages can be unpinned. Conversely, the bot must be an administrator with the "can_pin_messages" right or the "can_edit_messages" right to unpin messages in groups and channels respectively. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the business connection on behalf of which the message will be unpinned.>]
        },
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Identifier of a message to unpin. Required if business_connection_id is specified. If not specified, the most recent pinned message (by sending date) will be unpinned.>]
        }
      }
    },
    "unpinAllChatMessages" => {
      type: Bool,
      docs: [%<Use this method to clear the list of pinned messages in a chat. In private chats and channel direct messages chats, no additional rights are required to unpin all pinned messages. Conversely, the bot must be an administrator with the "can_pin_messages" right or the "can_edit_messages" right to unpin all pinned messages in groups and channels respectively. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        }
      }
    },
    "leaveChat" => {
      type: Bool,
      docs: [%<Use this method for your bot to leave a group, supergroup or channel. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`). Channel direct messages chats aren't supported; leave the corresponding channel instead.>]
        }
      }
    },
    "getChat" => {
      type: Hamilton::Types::ChatFullInfo,
      docs: [%<Use this method to get up-to-date information about the chat. Returns a ChatFullInfo object on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        }
      }
    },
    "getChatAdministrators" => {
      type: Array(Hamilton::Types::ChatMember),
      docs: [%<Use this method to get a list of administrators in a chat, which aren't bots. Returns an Array of `ChatMember` objects.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        }
      }
    },
    "getChatMemberCount" => {
      type: Int32,
      docs: [%<Use this method to get the number of members in a chat. Returns Int on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        }
      }
    },
    "getChatMember" => {
      type: Hamilton::Types::ChatMember,
      docs: [%<Use this method to get information about a member of a chat. The method is only guaranteed to work for other users if the bot is an administrator in the chat. Returns a `ChatMember` object on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        }
      }
    },
    "setChatStickerSet" => {
      type: Bool,
      docs: [%<Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field "can_set_sticker_set" optionally returned in `getChat` requests to check if the bot can use this method. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        },
        :sticker_set_name => {
          type: String,
          docs: [%<Name of the sticker set to be set as the group sticker set.>]
        }
      }
    },
    "deleteChatStickerSet" => {
      type: Bool,
      docs: [%<Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field "can_set_sticker_set" optionally returned in `getChat` requests to check if the bot can use this method. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup or channel (in the format `@channelusername`).>]
        }
      }
    },
    "getForumTopicIconStickers" => {
      type: Array(Hamilton::Types::Sticker),
      docs: [%<Use this method to get custom emoji stickers, which can be used as a forum topic icon by any user. Requires no parameters. Returns an Array of Sticker objects.>]
    },
    "createForumTopic" => {
      type: Hamilton::Types::ForumTopic,
      docs: [%<Use this method to create a topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. Returns information about the created topic as a `ForumTopic` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :name => {
          type: String,
          docs: [%<Topic name, 1-128 characters.>]
        },
        :icon_color => {
          type: Int32 | Nil,
          docs: [%<Color of the topic icon in RGB format. Currently, must be one of 7322096 (0x6FB9F0), 16766590 (0xFFD67E), 13338331 (0xCB86DB), 9367192 (0x8EEE98), 16749490 (0xFF93B2), or 16478047 (0xFB6F5F).>]
        },
        :icon_custom_emoji_id => {
          type: String | Nil,
          docs: [%<Unique identifier of the custom emoji shown as the topic icon. Use `getForumTopicIconStickers` to get all allowed custom emoji identifiers.>]
        }
      }
    },
    "editForumTopic" => {
      type: Bool,
      docs: [%<Use this method to edit name and icon of a topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights, unless it is the creator of the topic. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32,
          docs: [%<Unique identifier for the target message thread of the forum topic>]
        },
        :name => {
          type: String | Nil,
          docs: [%<New topic name, 0-128 characters. If not specified or empty, the current name of the topic will be kept.>]
        },
        :icon_custom_emoji_id => {
          type: String | Nil,
          docs: [%<New unique identifier of the custom emoji shown as the topic icon. Use `getForumTopicIconStickers` to get all allowed custom emoji identifiers. Pass an empty string to remove the icon. If not specified, the current icon will be kept.>]
        }
      }
    },
    "closeForumTopic" => {
      type: Bool,
      docs: [%<Use this method to close an open topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights, unless it is the creator of the topic. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32,
          docs: [%<Unique identifier for the target message thread of the forum topic.>]
        }
      }
    },
    "reopenForumTopic" => {
      type: Bool,
      docs: [%<Use this method to reopen a closed topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights, unless it is the creator of the topic. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32,
          docs: [%<Unique identifier for the target message thread of the forum topic.>]
        }
      }
    },
    "deleteForumTopic" => {
      type: Bool,
      docs: [%<Use this method to delete a forum topic along with all its messages in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_delete_messages" administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32,
          docs: [%<Unique identifier for the target message thread of the forum topic.>]
        }
      }
    },
    "unpinAllForumTopicMessages" => {
      type: Bool,
      docs: [%<Use this method to clear the list of pinned messages in a forum topic. The bot must be an administrator in the chat for this to work and must have the "can_pin_messages" administrator right in the supergroup. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :message_thread_id => {
          type: Int32,
          docs: [%<Unique identifier for the target message thread of the forum topic.>]
        }
      }
    },
    "editGeneralForumTopic" => {
      type: Bool,
      docs: [%<Use this method to edit the name of the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        },
        :name => {
          type: String,
          docs: [%<New topic name, 1-128 characters.>]
        }
      }
    },
    "closeGeneralForumTopic" => {
      type: Bool,
      docs: [%<Use this method to close an open "General" topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        }
      }
    },
    "reopenGeneralForumTopic" => {
      type: Bool,
      docs: [%<Use this method to reopen a closed "General" topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. The topic will be automatically unhidden if it was hidden. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        }
      }
    },
    "hideGeneralForumTopic" => {
      type: Bool,
      docs: [%<Use this method to hide the "General" topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. The topic will be automatically closed if it was open. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        }
      }
    },
    "unhideGeneralForumTopic" => {
      type: Bool,
      docs: [%<Use this method to unhide the "General" topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the "can_manage_topics" administrator rights. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        }
      }
    },
    "unpinAllGeneralForumTopicMessages" => {
      type: Bool,
      docs: [%<Use this method to clear the list of pinned messages in a "General" forum topic. The bot must be an administrator in the chat for this to work and must have the "can_pin_messages" administrator right in the supergroup. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target supergroup (in the format `@channelusername`).>]
        }
      }
    },
    "answerCallbackQuery" => {
      type: Bool,
      docs: [%<Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.>, %<Alternatively, the user can be redirected to the specified Game URL. For this option to work, you must first create a game for your bot via @BotFather and accept the terms. Otherwise, you may use links like `t.me/your_bot?start=XXXX` that open your bot with a parameter.>],
      params: {
        :callback_query_id => {
          type: String,
          docs: [%<Unique identifier for the query to be answered.>]
        },
        :text => {
          type: String | Nil,
          docs: [%<Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters.>]
        },
        :show_alert => {
          type: Bool | Nil,
          docs: [%<If True, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.>]
        },
        :url => {
          type: String | Nil,
          docs: [%<URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @BotFather, specify the URL that opens your game - note that this will only work if the query comes from a "callback_game" button.>, %<Otherwise, you may use links like `t.me/your_bot?start=XXXX` that open your bot with a parameter.>]
        },
        :cache_time => {
          type: Int32 | Nil,
          docs: [%<The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.>]
        }
      }
    },
    "getUserChatBoosts" => {
      type: Hamilton::Types::UserChatBoosts,
      docs: [%<Use this method to get the list of boosts added to a chat by a user. Requires administrator rights in the chat. Returns a `UserChatBoosts` object.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the chat or username of the channel (in the format `@channelusername`).>]
        },
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        }
      }
    },
    "getBusinessConnection" => {
      type: Hamilton::Types::BusinessConnection,
      docs: [%<Use this method to get information about the connection of the bot with a business account. Returns a `BusinessConnection` object on success.>],
      params: {
        :business_connection_id => {
          type: Int32,
          docs: [%<Unique identifier of the business connection.>]
        }
      }
    },
    "setMyCommands" => {
      type: Bool,
      docs: [%<Use this method to change the list of the bot's commands. Returns True on success.>],
      params: {
        :commands => {
          type: Array(Hamilton::Types::BotCommand),
          docs: [%<A JSON-serialized list of bot commands to be set as the list of the bot's commands. At most 100 commands can be specified.>]
        },
        :scope => {
          type: Hamilton::Types::BotCommandScope | Nil,
          docs: [%<A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to `BotCommandScopeDefault`.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands.>]
        }
      }
    },
    "deleteMyCommands" => {
      type: Bool,
      docs: [%<Use this method to delete the list of the bot's commands for the given scope and user language. After deletion, higher level commands will be shown to affected users. Returns True on success.>],
      params: {
        :scope => {
          type: Hamilton::Types::BotCommandScope | Nil,
          docs: [%<A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to `BotCommandScopeDefault`.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands.>]
        }
      }
    },
    "getMyCommands" => {
      type: Array(Hamilton::Types::BotCommand),
      docs: [%<Use this method to get the current list of the bot's commands for the given scope and user language. Returns an Array of BotCommand objects. If commands aren't set, an empty list is returned.>],
      params: {
        :scope => {
          type: Hamilton::Types::BotCommandScope | Nil,
          docs: [%<A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to `BotCommandScopeDefault`.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code or an empty string.>]
        }
      }
    },
    "setMyName" => {
      type: Bool,
      docs: [%<Use this method to change the bot's name. Returns True on success.>],
      params: {
        :name => {
          type: String | Nil,
          docs: [%<New bot name; 0-64 characters. Pass an empty string to remove the dedicated name for the given language.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands.>]
        }
      }
    },
    "getMyName" => {
      type: Hamilton::Types::BotName,
      docs: [%<Use this method to get the current bot name for the given user language. Returns `BotName` on success.>],
      params: {
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code or an empty string.>]
        }
      }
    },
    "setMyDescription" => {
      type: Nil,
      docs: [%<Use this method to change the bot's description, which is shown in the chat with the bot if the chat is empty. Returns True on success.>],
      params: {
        :description => {
          type: String | Nil,
          docs: [%<New bot description; 0-512 characters. Pass an empty string to remove the dedicated description for the given language.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands.>]
        }
      }
    },
    "getMyDescription" => {
      type: Hamilton::Types::BotDescription,
      docs: [%<Use this method to get the current bot description for the given user language. Returns `BotDescription` on success.>],
      params: {
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code or an empty string.>]
        }
      }
    },
    "setMyShortDescription" => {
      type: Bool,
      docs: [%<Use this method to change the bot's short description, which is shown on the bot's profile page and is sent together with the link when users share the bot. Returns True on success.>],
      params: {
        :short_description => {
          type: String | Nil,
          docs: [%<New short description for the bot; 0-120 characters. Pass an empty string to remove the dedicated short description for the given language.>]
        },
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code. If empty, the short description will be applied to all users for whose language there is no dedicated short description.>]
        }
      }
    },
    "getMyShortDescription" => {
      type: Hamilton::Types::BotShortDescription,
      docs: [%<Use this method to get the current bot short description for the given user language. Returns `BotShortDescription` on success.>],
      params: {
        :language_code => {
          type: String | Nil,
          docs: [%<A two-letter ISO 639-1 language code or an empty string.>]
        }
      }
    },
    "setChatMenuButton" => {
      type: Bool,
      docs: [%<Use this method to change the bot's menu button in a private chat, or the default menu button. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32,
          docs: [%<Unique identifier for the target private chat. If not specified, default bot's menu button will be changed.>]
        },
        :menu_button => {
          type: Hamilton::Types::MenuButton | Nil,
          docs: [%<A JSON-serialized object for the bot's new menu button. Defaults to `MenuButtonDefault`.>]
        }
      }
    },
    "getChatMenuButton" => {
      type: Hamilton::Types::MenuButton,
      docs: [%<Use this method to get the current value of the bot's menu button in a private chat, or the default menu button. Returns `MenuButton` on success.>],
      params: {
        :chat_id => {
          type: Int32,
          docs: [%<Unique identifier for the target private chat. If not specified, default bot's menu button will be returned.>]
        }
      }
    },
    "setMyDefaultAdministratorRights" => {
      type: Bool,
      docs: [%<Use this method to change the default administrator rights requested by the bot when it's added as an administrator to groups or channels. These rights will be suggested to users, but they are free to modify the list before adding the bot. Returns True on success.>],
      params: {
        :rights => {
          type: Hamilton::Types::ChatAdministratorRights | Nil,
          docs: [%<A JSON-serialized object describing new default administrator rights. If not specified, the default administrator rights will be cleared.>]
        },
        :for_channels => {
          type: Bool | Nil,
          docs: [%<Pass True to change the default administrator rights of the bot in channels. Otherwise, the default administrator rights of the bot for groups and supergroups will be changed.>]
        }
      }
    },
    "getMyDefaultAdministratorRights" => {
      type: Hamilton::Types::ChatAdministratorRights,
      docs: [%<Use this method to get the current default administrator rights of the bot. Returns `ChatAdministratorRights` on success.>],
      params: {
        :for_channels => {
          type: Bool | Nil,
          docs: [%<Pass True to get default administrator rights of the bot in channels. Otherwise, default administrator rights of the bot for groups and supergroups will be returned.>]
        }
      }
    },
    "getAvailableGifts" => {
      type: Hamilton::Types::Gifts,
      docs: [%<Returns the list of gifts that can be sent by the bot to users and channel chats. Requires no parameters. Returns a `Gifts` object.>]
    },
    "sendGift" => {
      type: Bool,
      docs: [%<Sends a gift to the given user or channel chat. The gift can't be converted to Telegram Stars by the receiver. Returns True on success.>],
      params: {
        :user_id => {
          type: Int32 | Nil,
          docs: [%<Required if `chat_id` is not specified. Unique identifier of the target user who will receive the gift.>]
        },
        :chat_id => {
          type: Int32 | String | Nil,
          docs: [%<Required if `user_id` is not specified. Unique identifier for the chat or username of the channel (in the format `@channelusername`) that will receive the gift.>]
        },
        :gift_id => {
          type: String,
          docs: [%<Identifier of the gift.>]
        },
        :pay_for_upgrade => {
          type: Bool | Nil,
          docs: [%<Pass True to pay for the gift upgrade from the bot's balance, thereby making the upgrade free for the receiver.>]
        },
        :text => {
          type: String | Nil,
          docs: [%<Text that will be shown along with the gift; 0-128 characters.>]
        },
        :text_parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the text. Entities other than “bold”, “italic”, “underline”, “strikethrough”, “spoiler”, and “custom_emoji” are ignored.>]
        },
        :text_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the gift text. It can be specified instead of `text_parse_mode`. Entities other than “bold”, “italic”, “underline”, “strikethrough”, “spoiler”, and “custom_emoji” are ignored.>]
        }
      }
    },
    "giftPremiumSubscription" => {
      type: Bool,
      docs: [%<Gifts a Telegram Premium subscription to the given user. Returns True on success.>],
      params: {
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user who will receive a Telegram Premium subscription.>]
        },
        :month_count => {
          type: Int32,
          docs: [%<Number of months the Telegram Premium subscription will be active for the user; must be one of 3, 6, or 12.>]
        },
        :star_count => {
          type: Int32,
          docs: [%<Number of Telegram Stars to pay for the Telegram Premium subscription; must be 1000 for 3 months, 1500 for 6 months, and 2500 for 12 months.>]
        },
        :text => {
          type: String | Nil,
          docs: [%<Text that will be shown along with the service message about the subscription; 0-128 characters.>]
        },
        :text_parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the text. Entities other than “bold”, “italic”, “underline”, “strikethrough”, “spoiler”, and “custom_emoji” are ignored.>]
        },
        :text_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the gift text. It can be specified instead of `text_parse_mode`. Entities other than “bold”, “italic”, “underline”, “strikethrough”, “spoiler”, and “custom_emoji” are ignored.>]
        }
      }
    },
    "verifyUser" => {
      type: Bool,
      docs: [%<Verifies a user on behalf of the organization which is represented by the bot. Returns True on success.>],
      params: {
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        },
        :custom_description => {
          type: String | Nil,
          docs: [%<Custom description for the verification; 0-70 characters. Must be empty if the organization isn't allowed to provide a custom verification description.>]
        }
      }
    },
    "verifyChat" => {
      type: Bool,
      docs: [%<Verifies a chat on behalf of the organization which is represented by the bot. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`). Channel direct messages chats can't be verified.>]
        },
        :custom_description => {
          type: String | Nil,
          docs: [%<Custom description for the verification; 0-70 characters. Must be empty if the organization isn't allowed to provide a custom verification description.>]
        }
      }
    },
    "removeUserVerification" => {
      type: Bool,
      docs: [%<Removes verification from a user who is currently verified on behalf of the organization represented by the bot. Returns True on success.>],
      params: {
        :user_id => {
          type: Int32,
          docs: [%<Unique identifier of the target user.>]
        }
      }
    },
    "removeChatVerification" => {
      type: Bool,
      docs: [%<Removes verification from a chat that is currently verified on behalf of the organization represented by the bot. Returns True on success.>],
      params: {
        :chat_id => {
          type: Int32 | String,
          docs: [%<Unique identifier for the target chat or username of the target channel (in the format `@channelusername`).>]
        }
      }
    },
    "readBusinessMessage" => {
      type: Bool,
      docs: [%<Marks incoming message as read on behalf of a business account. Requires the "can_read_messages" business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which to read the message.>]
        },
        :chat_id => {
          type: Int32,
          docs: [%<Unique identifier of the chat in which the message was received. The chat must have been active in the last 24 hours.>]
        },
        :message_id => {
          type: Int32,
          docs: [%<Unique identifier of the message to mark as read>]
        }
      }
    },
    "deleteBusinessMessages" => {
      type: Bool,
      docs: [%<Delete messages on behalf of a business account. Requires the "can_delete_sent_messages" business bot right to delete messages sent by the bot itself, or the "can_delete_all_messages" business bot right to delete any message. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which to delete the messages.>]
        },
        :message_ids => {
          type: Array(Int32),
          docs: [%<A JSON-serialized list of 1-100 identifiers of messages to delete. All messages must be from the same chat. See deleteMessage for limitations on which messages can be deleted.>]
        }
      }
    },
    "setBusinessAccountName" => {
      type: Bool,
      docs: [%<Changes the first and last name of a managed business account. Requires the can_change_name business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which to change the name.>]
        },
        :first_name => {
          type: String,
          docs: [%<The new value of the first name for the business account; 1-64 characters.>]
        },
        :last_name => {
          type: String | Nil,
          docs: [%<The new value of the last name for the business account; 0-64 characters.>]
        }
      }
    },
    "setBusinessAccountUsername" => {
      type: Bool,
      docs: [%<Changes the username of a managed business account. Requires the can_change_username business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which to change the username.>]
        },
        :username => {
          type: String | Nil,
          docs: [%<The new value of the username for the business account; 0-32 characters.>]
        }
      }
    },
    "setBusinessAccountBio" => {
      type: Bool,
      docs: [%<Changes the bio of a managed business account. Requires the can_change_bio business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection on behalf of which to change the bio.>]
        },
        :bio => {
          type: String | Nil,
          docs: [%<The new value of the bio for the business account; 0-140 characters.>]
        }
      }
    },
    "setBusinessAccountProfilePhoto" => {
      type: Bool,
      docs: [%<Changes the profile photo of a managed business account. Requires the "can_edit_profile_photo" business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :photo => {
          type: Hamilton::Types::InputProfilePhoto,
          docs: [%<The new profile photo to set>]
        },
        :is_public => {
          type: Bool | Nil,
          docs: [%<Pass True to set the public photo, which will be visible even if the main photo is hidden by the business account's privacy settings. An account can have only one public photo.>]
        }
      }
    },
    "removeBusinessAccountProfilePhoto" => {
      type: Bool,
      docs: [%<Removes the current profile photo of a managed business account. Requires the can_edit_profile_photo business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :is_public => {
          type: Bool | Nil,
          docs: [%<Pass True to remove the public photo, which is visible even if the main photo is hidden by the business account's privacy settings. After the main photo is removed, the previous profile photo (if present) becomes the main photo.>]
        }
      }
    },
    "setBusinessAccountGiftSettings" => {
      type: Bool,
      docs: [%<Changes the privacy settings pertaining to incoming gifts in a managed business account. Requires the "can_change_gift_settings" business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :show_gift_button => {
          type: Bool,
          docs: [%<Pass True, if a button for sending a gift to the user or by the business account must always be shown in the input field.>]
        },
        :accepted_gift_types => {
          type: Hamilton::Types::AcceptedGiftTypes,
          docs: [%<Types of gifts accepted by the business account.>]
        }
      }
    },
    "getBusinessAccountStarBalance" => {
      type: Hamilton::Types::StarAmount,
      docs: [%<Returns the amount of Telegram Stars owned by a managed business account. Requires the "can_view_gifts_and_stars" business bot right. Returns `StarAmount` on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        }
      }
    },
    "transferBusinessAccountStars" => {
      type: Bool,
      docs: [%<Transfers Telegram Stars from the business account balance to the bot's balance. Requires the "can_transfer_stars" business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :star_count => {
          type: Int32,
          docs: [%<Number of Telegram Stars to transfer; 1-10000.>]
        }
      }
    },
    "getBusinessAccountGifts" => {
      type: Hamilton::Types::OwnedGifts,
      docs: [%<Returns the gifts received and owned by a managed business account. Requires the "can_view_gifts_and_stars" business bot right. Returns `OwnedGifts` on success.>],
      params: {
        :business_user_id => {
          type: String,
          docs: [%<Unique identifier of the business user.>]
        },
        :exclude_unsaved => {
          type: Bool | Nil,
          docs: [%<Pass True to exclude gifts that aren't saved to the account's profile page.>]
        },
        :exclude_saved => {
          type: Bool | Nil,
          docs: [%<Pass True to exclude gifts that are saved to the account's profile page.>]
        },
        :exclude_unlimited => {
          type: Bool | Nil,
          docs: [%<Pass True to exclude gifts that can be purchased an unlimited number of times.>]
        },
        :exclude_limited => {
          type: Bool | Nil,
          docs: [%<Pass True to exclude gifts that can be purchased a limited number of times.>]
        },
        :exclude_unique => {
          type: Bool | Nil,
          docs: [%<Pass True to exclude unique gifts.>]
        },
        :sort_by_price => {
          type: Bool | Nil,
          docs: [%<Pass True to sort results by gift price instead of send date. Sorting is applied before pagination.>]
        },
        :offset => {
          type: String | Nil,
          docs: [%<Offset of the first entry to return as received from the previous request; use empty string to get the first chunk of results.>]
        },
        :limit => {
          type: Int32 | Nil,
          docs: [%<The maximum number of gifts to be returned; 1-100. Defaults to 100.>]
        }
      }
    },
    "convertGiftToStars" => {
      type: Bool,
      docs: [%<Converts a given regular gift to Telegram Stars. Requires the can_convert_gifts_to_stars business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :owned_gift_id => {
          type: String,
          docs: [%<Unique identifier of the regular gift that should be converted to Telegram Stars>]
        }
      }
    },
    "upgradeGift" => {
      type: Bool,
      docs: [%<Upgrades a given regular gift to a unique gift. Requires the "can_transfer_and_upgrade_gifts" business bot right. Additionally requires the "can_transfer_stars" business bot right if the upgrade is paid. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :owned_gift_id => {
          type: String,
          docs: [%<Unique identifier of the regular gift that should be upgraded to a unique one.>]
        },
        :keep_original_details => {
          type: Bool | Nil,
          docs: [%<Pass True to keep the original gift text, sender and receiver in the upgraded gift.>]
        },
        :star_count => {
          type: Int32 | Nil,
          docs: [%<The amount of Telegram Stars that will be paid for the upgrade from the business account balance. If `gift.prepaid_upgrade_star_count` is greater than 0, then pass 0, otherwise, the "can_transfer_stars" business bot right is required and `gift.upgrade_star_count` must be passed.>]
        }
      }
    },
    "transferGift" => {
      type: Bool,
      docs: [%<Transfers an owned unique gift to another user. Requires the can_transfer_and_upgrade_gifts business bot right. Requires can_transfer_stars business bot right if the transfer is paid. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :owned_gift_id => {
          type: String,
          docs: [%<Unique identifier of the regular gift that should be transferred.>]
        },
        :new_owner_chat_id => {
          type: Int32,
          docs: [%<Unique identifier of the chat which will own the gift. The chat must be active in the last 24 hours.>]
        },
        :star_count => {
          type: Int32 | Nil,
          docs: [%<The amount of Telegram Stars that will be paid for the transfer from the business account balance. If positive, then the "can_transfer_stars" business bot right is required.>]
        }
      }
    },
    "postStory" => {
      type: Hamilton::Types::Story,
      docs: [%<Posts a story on behalf of a managed business account. Requires the can_manage_stories business bot right. Returns Story on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :content => {
          type: Hamilton::Types::InputStoryContent,
          docs: [%<Content of the story.>]
        },
        :active_period => {
          type: Int32,
          docs: [%<Period after which the story is moved to the archive, in seconds; must be one of `6 * 3600`, `12 * 3600`, `86400`, or `2 * 86400`.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Caption of the story, 0-2048 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the story caption.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :areas => {
          type: Array(Hamilton::Types::StoryArea) | Nil,
          docs: [%<A JSON-serialized list of clickable areas to be shown on the story.>]
        },
        :post_to_chat_page => {
          type: Bool | Nil,
          docs: [%<Pass True to keep the story accessible after it expires.>]
        },
        :protect_content => {
          type: Bool | Nil,
          docs: [%<Pass True if the content of the story must be protected from forwarding and screenshotting.>]
        }
      }
    },
    "editStory" => {
      type: Hamilton::Types::Story,
      docs: [%<Edits a story previously posted by the bot on behalf of a managed business account. Requires the "can_manage_stories" business bot right. Returns Story on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :story_id => {
          type: Int32,
          docs: [%<Unique identifier of the story to edit.>]
        },
        :content => {
          type: Hamilton::Types::StoryContent,
          docs: [%<Content of the story.>]
        },
        :caption => {
          type: String | Nil,
          docs: [%<Caption of the story, 0-2048 characters after entities parsing.>]
        },
        :parse_mode => {
          type: String | Nil,
          docs: [%<Mode for parsing entities in the story caption. See formatting options for more details.>]
        },
        :caption_entities => {
          type: Array(Hamilton::Types::MessageEntity) | Nil,
          docs: [%<A JSON-serialized list of special entities that appear in the caption, which can be specified instead of `parse_mode`.>]
        },
        :areas => {
          type: Array(Hamilton::Types::StoryArea) | Nil,
          docs: [%<A JSON-serialized list of clickable areas to be shown on the story.>]
        }
      }
    },
    "deleteStory" => {
      type: Bool,
      docs: [%<Deletes a story previously posted by the bot on behalf of a managed business account. Requires the "can_manage_stories" business bot right. Returns True on success.>],
      params: {
        :business_connection_id => {
          type: String,
          docs: [%<Unique identifier of the business connection.>]
        },
        :story_id => {
          type: Int32,
          docs: [%<Unique identifier of the story to delete.>]
        }
      }
    }
  }
end
