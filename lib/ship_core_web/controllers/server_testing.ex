defmodule ShipCoreWeb.TestController do
  require Record
  alias ShipCore.{Repo, ShipType}

  use ShipCoreWeb, :controller

  def ping(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{pong: true}))
  end

  def get_ships(conn, _params) do
    ships = Repo.all(ShipType)

    data =
      Enum.map(ships, fn ship ->
        %{
          name: ship.name,
          id: ship.id
        }
      end)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(data))
  end

  defp insert_ship_with_rarity(rarity) do
    ship = %ShipType{
      name: "Test Ship",
      description: "Test Description",
      classId: "Test Class",
      rarity: rarity
    }

    Repo.insert(ship)
  end

  def new_ship(conn, _params) do
    ShipCoreWeb.MathHelper.get_rarities()
    |> Enum.map(fn {key, _value} ->
      insert_ship_with_rarity(key)
    end)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{success: true}))
  end
end
