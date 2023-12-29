defmodule ShipCore.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "Users" do
    field :email, :string
    field :hash_password, :string
    field :name, :string
    field :username, :string
    belongs_to :account, ShipCore.Accounts.Account
    has_many :ships, ShipCore.Ships.Ship

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :hash_password, :name, :username])
    |> validate_required([:email, :hash_password, :name, :username])
  end
end
