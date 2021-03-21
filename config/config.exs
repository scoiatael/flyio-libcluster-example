# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :flyio_libcluster_example, FlyioLibclusterExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ufpYUJdeQZYJqnSQ50P/xs/4MbOciybu6PFBboc/np4hbRWdm4TugbqYfLR4rCGM",
  render_errors: [view: FlyioLibclusterExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FlyioLibclusterExample.PubSub,
  live_view: [signing_salt: "WFC64djK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
