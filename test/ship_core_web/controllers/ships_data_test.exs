defmodule ShipCoreWeb.ShipsDataTest do
  use ShipCoreWeb.ConnCase, async: true
  alias ShipCore.{Repo, ShipType, ShipsData}
  alias ShipCoreWeb.MathHelper

  import Ecto.Query, only: [from: 2]

  defp resetDB() do
    Repo.delete_all(ShipType)
  end

  defp insert_ship() do
    ship = %ShipType{
      name: "Test Ship",
      description: "Test Description",
      classId: "Test Class",
      rarity: "Test Rarity"
    }

    Repo.insert(ship)
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

  test "make sure that getting all ships results a non null response" do
    resetDB()
    insert_ship()
    insert_ship()

    ships = ShipsData.get_all_ships()

    assert ships != nil
    assert ships != []
    assert Enum.count(ships) == 2
  end

  test "get by name" do
    insert_ship()
    insert_ship()

    ships = ShipsData.get_shipTypes_by_name("Test Ship")

    assert ships != nil
    assert ships != []
    assert Enum.count(ships) == 2
  end

  test "get by id" do
    insert_ship()

    case Repo.all(ShipType) do
      [] ->
        assert false

      [ship | _] ->
        ship = ShipsData.get_shipType_by_id(ship.id)
        assert ship != nil
        assert ship.name == "Test Ship"
        assert ship.description == "Test Description"
        assert ship.classId == "Test Class"
        assert ship.rarity == "Test Rarity"
    end
  end

  test "test 1 of each rarity exists in db" do
    rarities = MathHelper.get_rarities()

    for {key, _value} <- rarities do
      insert_ship_with_rarity(key)
    end

    for {key, _value} <- rarities do
      ships = Repo.all(from s in ShipType, where: s.rarity == ^key)
      assert Enum.count(ships) == 1
    end
  end

  def sample_list_of_rarities(amt, lst) do
    if amt == 0 do
      lst
    else
      rarity = MathHelper.random_rarity()
      sample_list_of_rarities(amt - 1, [rarity | lst])
    end
  end

  test "sample rarities" do
    raritiesSample = sample_list_of_rarities(300, [])

    common = raritiesSample |> Enum.filter(fn x -> x == "common" end)
    uncommon = raritiesSample |> Enum.filter(fn x -> x == "uncommon" end)
    rare = raritiesSample |> Enum.filter(fn x -> x == "rare" end)
    epic = raritiesSample |> Enum.filter(fn x -> x == "epic" end)
    legendary = raritiesSample |> Enum.filter(fn x -> x == "legendary" end)

    commonCount = Enum.count(common)
    uncommonCount = Enum.count(uncommon)
    rareCount = Enum.count(rare)
    epicCount = Enum.count(epic)
    legendaryCount = Enum.count(legendary)

    assert commonCount > uncommonCount
    assert uncommonCount > rareCount
    assert rareCount > epicCount

    # assert commonCount > 0
    # assert uncommonCount > 0
    # assert rareCount > 0
    # assert epicCount > 0
    # assert legendaryCount > 0
    IO.puts ""
    IO.puts("Out of 300 samples (~100 games):")
    IO.puts("Common: #{commonCount}")
    IO.inspect("Uncommon: #{uncommonCount}")
    IO.inspect("Rare: #{rareCount}")
    IO.inspect("Epic: #{epicCount}")
    IO.inspect("Legendary: #{legendaryCount}")

    # raritiesSample
    # |> Enum.each(fn x ->
    #   IO.inspect(x)
    # end)
  end
end
