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
          docs: [%<Mode for parsing entities in the message text. See formatting options for more details.>]
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
    }
  }
end
