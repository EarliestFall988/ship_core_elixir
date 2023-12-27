defmodule ShipCore.ShipType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ship_types" do
    field :classId, :string
    field :description, :string
    field :max_cost, :integer
    field :max_health, :integer
    field :max_shields, :integer
    field :max_speed, :integer
    field :min_cost, :integer
    field :min_health, :integer
    field :min_shields, :integer
    field :min_speed, :integer
    field :name, :string
    field :rarity, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ship_type, attrs) do
    ship_type
    |> cast(attrs, [:name, :description, :classId, :rarity, :min_cost, :max_cost, :min_speed, :max_speed, :min_health, :max_health, :min_shields, :max_shields])
    |> validate_required([:name, :description, :classId, :rarity, :min_cost, :max_cost, :min_speed, :max_speed, :min_health, :max_health, :min_shields, :max_shields])
  end
end
