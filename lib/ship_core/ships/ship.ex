defmodule ShipCore.Ships.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ships" do
    field :name, :string
    field :classId, :string
    field :description, :string
    field :rarity, :string
    field :cost, :integer
    field :health, :integer
    field :shields, :integer
    field :speed, :integer
    belongs_to :user, ShipCore.User
    belongs_to :ship_type, ShipCore.ShipType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:name, :classId, :description, :rarity, :cost, :health, :shields, :speed, :user_id, :ship_type_id])
    |> validate_required([:name, :classId, :description, :rarity, :cost, :health, :shields, :speed, :user_id, :ship_type_id])
  end

end
