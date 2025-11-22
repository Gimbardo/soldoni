# Soldoni

Ruby Gem that implements 2 minimal api interfaces, for Tito and Telegram, and uses them to notify for new ticket sales daily 

## Installation

Create a .env with the following keys:

``` bash
TITO_API_TOKEN=
TITO_ACCOUNT=
TITO_EVENT=
TELEGRAM_BOT_TOKEN=
TELEGRAM_CHAT_ID=
TZ=
```

then start the scheduled messages with docker detached

``` bash
docker compose up -d
```

or start it directly

``` bash
bundle install
./bin/schedule
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
