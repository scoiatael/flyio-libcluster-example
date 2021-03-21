defmodule FlyioLibclusterExampleWeb.PageController do
  use FlyioLibclusterExampleWeb, :controller
  alias FlyioLibclusterExample.Region

  def index(conn, _params) do
    render(conn, "index.html", %{
      nodes: Node.list([:connected, :this]) |> Enum.map(fn node -> {node, Region.get(node)} end)
    })
  end
end
