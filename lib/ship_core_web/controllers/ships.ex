defmodule ShipCoreWeb.Ships do
  require Record
  alias ShipCore.{Repo, ShipType, ShipsData}

  use ShipCoreWeb, :controller

  def get_all_ships(conn, _params) do
    ships = ShipsData.get_all_ships()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{ships: ships}))
  end

  def get_ship(conn, %{"id" => id}) do
    data = Repo.get(ShipType, id)

    ship = %{
      name: data.name,
      description: data.description,
      classId: data.classId,
      rarity: data.rarity
    }

    IO.inspect(ship)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{ship: ship}))
  end

  @doc """
    Get a random ship type from the database based on rarity
  """
  def get_ship_type(conn, _params) do
    ship = ShipsData.get_random_ship()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{ship: ship}))
  end

  def get_ships_options(conn, _params) do
    ship1 = ShipsData.get_random_ship()
    ship2 = ShipsData.get_random_ship()
    ship3 = ShipsData.get_random_ship()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!([ship1, ship2, ship3]))
  end
end
