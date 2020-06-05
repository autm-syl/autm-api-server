# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

#upload config
config :arc,
  storage: Arc.Storage.Local

config :monsys,
  ecto_repos: [Monsys.Repo]

config :monsys, Monsys.Guardian,
  issuer: "monsys",
  secret_key: "vLtypxqqVOKYF3c/9EKGc8lHBDBuLKgSLETGlu1ISB+hldrWlaS0Wu8DUbzczfbJ"

# Configures the endpoint
config :monsys, MonsysWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qCGJ9cSVEQPrYyGuT+Goz+BdRmGyY8ROj0RT7U4Lu4QEuRKMFbZF9wDz10ww7s1q",
  render_errors: [view: MonsysWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Monsys.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
