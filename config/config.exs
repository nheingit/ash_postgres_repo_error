# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ash, include_embedded_source_by_default?: true

config :postgres_error,
  map_bug: %{
    summary: %{
      chat_history: [
        %{"content" => "Default system prompt", "role" => "system"},
        %{
          "content" =>
            "Here's a collection of tweets from the Twitter list 'Web 3 Mid':\nTweet by KhanAbbas201 (2024-08-26 19:40:13.000000Z):\n@Rahatcodes told me I look good wearing the Eth shirt. https://t.co/xBugAt2tDi\nTweet by Rahatcodes (2024-08-26 19:42:55.000000Z):\n@KhanAbbas201 I dont recall saying this\nTweet by KhanAbbas201 (2024-08-26 19:44:08.000000Z):\n@Rahatcodes Damn what happened to your memory bruv?\nTweet by angelinarusse (2024-08-26 19:56:05.000000Z):\n@dabit3 Real degens call it Twitter\nTweet by angelinarusse (2024-08-26 20:13:58.000000Z):\n@hamseth They tried the same in Afghanistan and it didn’t go well for them.\nTweet by KhanAbbas201 (2024-08-26 20:39:53.000000Z):\nTweet by Osh_mahajan (2024-08-26 21:34:08.000000Z):\n@FedericoNoemie 🐾🐾🦘\nTweet by developer_dao (2024-08-26 21:39:59.000000Z):\n@ZwigoZwitscher @ArweaveEco @k4yls Wildly high praise, ty ty. @k4yls is 🔥 with a 🐶\nTweet by developer_dao (2024-08-26 21:41:17.000000Z):\nRT @ZwigoZwitscher : I've been into @ArweaveEco for years – as an interested outsider – and still learned new things in that course 👇. Thanks…\nTweet by angelin...eet by developer_dao (2024-08-26 22:18:09.000000Z):\nRT @jeremykauffman: BREAKING: France has arrested Gonzalve Bich, the CEO of Bic\nTweet by PatrickAlphaC (2024-08-26 22:26:16.000000Z):\n@oxfav @ar_io_network\n",
          "role" => "user"
        },
        %{"content" => "test", "role" => "user"},
        %{
          "content" => "It looks like you're testing the feature. How can I assist you further?",
          "role" => "assistant"
        }
      ]
    }
  }

config :spark,
  formatter: [
    remove_parens?: true,
    "Ash.Resource": [
      section_order: [
        :postgres,
        :resource,
        :code_interface,
        :actions,
        :policies,
        :pub_sub,
        :preparations,
        :changes,
        :validations,
        :multitenancy,
        :attributes,
        :relationships,
        :calculations,
        :aggregates,
        :identities
      ]
    ],
    "Ash.Domain": [section_order: [:resources, :policies, :authorization, :domain, :execution]]
  ]

config :postgres_error,
  ecto_repos: [PostgresError.Repo],
  generators: [timestamp_type: :utc_datetime],
  ash_domains: [PostgresError.Resource]

# Configures the endpoint
config :postgres_error, PostgresErrorWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PostgresErrorWeb.ErrorHTML, json: PostgresErrorWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PostgresError.PubSub,
  live_view: [signing_salt: "rBCnTdve"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :postgres_error, PostgresError.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  postgres_error: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  postgres_error: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
