defmodule ShipCore.Repo.Migrations.CreateShipTypes do
  use Ecto.Migration

  def change do
    create table(:ship_types) do
      add :name, :string
      add :description, :string
      add :classId, :string
      add :rarity, :string
      add :min_cost, :integer
      add :max_cost, :integer
      add :min_speed, :integer
      add :max_speed, :integer
      add :min_health, :integer
      add :max_health, :integer
      add :min_shields, :integer
      add :max_shields, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
