# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deliv,
  ecto_repos: [Deliv.Repo]

# Configures the endpoint
config :deliv, DelivWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HkLzsIhRKVHXaEiJM+o0MuNqkP3eUDH8dI2tSMBI/30wiD/LhkjB+0Qb2QEN3s6z",
  render_errors: [view: DelivWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Deliv.PubSub,
  live_view: [signing_salt: "Y7xfgL8P"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :deliv, :pow,
  user: Deliv.Users.User,
  repo: Deliv.Repo,
  web_module: DelivWeb,
  messages_backend: DelivWeb.Pow.Messages
