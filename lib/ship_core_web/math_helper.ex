defmodule ShipCoreWeb.MathHelper do
  def success?(p, total) do
    rand = :rand.uniform(total)

    if rand <= p do
      true
    else
      false
    end
  end

  def get_rarities() do
    # values set to an eighth of the previous value
    rarity = %{
      "common" => 1,
      "uncommon" => 1 / 2,
      "rare" => 1 / 10,
      "epic" => 1 / 50,
      "legendary" => 1 / 200
    }

    rarity
  end

  @doc """
    Get a random number between 0 and 1 (do some extra work to make it more random)
  """
  def random(r) do
    case r do
      0 ->
        :rand.uniform()

      _ ->
        :rand.uniform()
        random(r - 1)
    end
  end

  def random_rarity() do
    rand = random(:rand.uniform(100))

    IO.puts("Random: #{rand}")

    result =
      get_rarities()
      |> Enum.filter(fn {_, value} -> rand <= value end)
      |> Enum.min_by(fn {_, value} -> value end)

    case result do
      {key, _value} ->
        key
    end
  end
end
