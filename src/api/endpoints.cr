class Hamilton::Api
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
    }
  }
end