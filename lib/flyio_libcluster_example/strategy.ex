defmodule FlyioLibclusterExample.Strategy do
  @moduledoc """
  Assumes you have nodes that respond to the specified DNS query (A record), and which follow the node name pattern of
  `<name>@<ip-address>`. If your setup matches those assumptions, this strategy will periodically poll DNS and connect
  all nodes it finds.
  ## Options
  * `poll_interval` - How often to poll in milliseconds (optional; default: 5_000)
  * `query` - DNS query to use (required; e.g. "my-app.example.com")
  * `node_basename` - The short name of the nodes you wish to connect to (required; e.g. "my-app")
  ## Usage
      config :libcluster,
        topologies: [
          dns_poll_example: [
            strategy: #{__MODULE__},
            config: [
              polling_interval: 5_000,
              query: "my-app.example.com",
              node_basename: "my-app"]]]
  """

  alias Cluster.Strategy.{State, DNSPoll}

  def start_link([%State{config: config} = state]),
    do: GenServer.start_link(DNSPoll, [%State{state | config: with_defaults(config)}])

  defp with_defaults(config) do
    [
      query: "#{app_name()}.internal",
      node_basename: release_name()
    ]
    |> Keyword.merge(config)
  end

  defp app_name(), do: System.fetch_env!("FLY_APP_NAME")
  defp release_name(), do: System.fetch_env!("RELEASE_NAME")
end
