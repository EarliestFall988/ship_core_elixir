defmodule ShipCore.ShipsData do
  alias ShipCore.{Repo, ShipType}
  alias ShipCoreWeb.MathHelper

  import Ecto.Query, only: [from: 2]

  @doc """
  Get all ships from the database
  """
  def get_all_ships() do
    Repo.all(ShipType)
    |> Enum.map(fn ship ->
      %{
        name: ship.name,
        description: ship.description,
        classId: ship.classId,
        rarity: ship.rarity
      }
    end)
  end

  @doc """
    Get a single ship from the database by id
  """

  def get_shipType_by_id(id) do
    ship = Repo.get(ShipType, id)

    %{
      name: ship.name,
      description: ship.description,
      classId: ship.classId,
      rarity: ship.rarity
    }
  end

  def get_shipTypes_by_name(name) do
    Repo.all(from s in ShipType, where: s.name == ^name)
    |> Enum.map(fn ship ->
      %{
        name: ship.name,
        description: ship.description,
        classId: ship.classId,
        rarity: ship.rarity
      }
    end)
  end

  @doc """
    Get a random ship from the database based on rarity
  """
  def get_random_ship() do

    r = MathHelper.random_rarity()

    ship = Repo.all(from s in ShipType, where: s.rarity == ^r)
    |> Enum.random()

    %{
      name: ship.name,
      description: ship.description,
      classId: ship.classId,
      rarity: ship.rarity
    }
  end
end
