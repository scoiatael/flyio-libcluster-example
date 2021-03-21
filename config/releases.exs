import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")

config :flyio_libcluster_example, FlyioLibclusterExampleWeb.Endpoint,
  url: [
    host: System.fetch_env!("ENDPOINT_URL_HOST"),
    port: System.fetch_env!("ENDPOINT_URL_PORT") |> String.to_integer()
  ],
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :flyio_libcluster_example, FlyioLibclusterExampleWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
app_name = System.fetch_env!("FLY_APP_NAME")
release_name = System.fetch_env!("RELEASE_NAME")

config :libcluster,
  topologies: [
    fly6pn: [
      strategy: Elixir.Cluster.Strategy.DNSPoll,
      config: [
        polling_interval: 5_000,
        query: "#{app_name}.internal",
        node_basename: release_name
      ]
    ]
  ]
