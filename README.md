# hamilton

Crystal wrapper for Telegram Bot API.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     hamilton:
       github: Scurrra/hamilton
   ```

2. Run `shards install`

## Usage

```crystal
require "hamilton"

API = Hamilton::Api.new(token: "<YOUR-API-TOKEN>")

handler = Hamilton::CmdHandler.new

@[Handler(handler)]
@[Handle(command: "/start")]
def handle_start_command(argument, context, update)
  # logic here
  return nil
end

@[Handler(handler)]
@[Handle(command: "help")]
def handle_help_command(argument, context, update)
  # logic here
  return nil
end

bot = Hamilton::Bot.new(
  api: API,
  handlers: [
    Hamilton::LogHandler.new, 
    handler
  ]
)

Signal::INT.trap do
  bot.stop
end

bot.listen
```

Usage guide can be found [here](https://scurrra.github.io/blog/hamilton-guide/).

## Possible issues:
 - Sending files were not tested yet, so it may fail.

## Contributing

1. Fork it (<https://github.com/Scurrra/hamilton/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Scurrra](https://github.com/Scurrra) - creator and maintainer
