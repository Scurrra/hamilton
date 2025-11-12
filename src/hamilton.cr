require "./errors"
require "./types"
require "./api"
require "./handler"
require "./bot"
require "./handlers/*"

# Telegram Bot API wrapper for Crystal.
# 
# Library provides following mudules and classes:
#  - `Hamilton::Types` --- module that provides types (structures) used in the API;
#  - `Hamilton::Api` --- class that provides all the API methods with typecheck for arguments;
#  - `Hamilton::Bot` --- class that implements update handling with long pooling by chain of provided instances of `Hamilton::Handler`;
#  - `Hamilton::Handler` --- module to give classes handler functionalities;
#  - `Hamilton::LogHandler` --- handler for logging incoming updates and time consumed by the handlers next in chain;
#  - `Hamilton::CmdHandler` --- handler for most common types of updates;
#  - `Hamilton::Any` --- a mutable version of `JSON::Any`;
#  - `Hamilton::Storage` --- a wrapper for easier usage of `Hash(Symbol, Hamilton::Any)`; 
#  - `Hamilton::Context` --- primitive for storing previous methods that handled last updates in the user flow and some contextual data.
#
# `Hamilton::CmdHandler` uses following annotations, that are used without `Hamilton::` prefix:
#  - `@[Handler(...)]` to specify which instance of `Hamilton::CmdHandler` the method belongs to;
#  - `@[Handle(...)]` to specify which type of updates the method can handle;
#  - `@[For(...)]` to specify a list of possible methods that handled previous updates in the user flow.
module Hamilton
  VERSION = "0.3.1"
end
