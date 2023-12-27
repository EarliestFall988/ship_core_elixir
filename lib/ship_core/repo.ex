defmodule ShipCore.Repo do
  use Ecto.Repo,
    otp_app: :ship_core,
    adapter: Ecto.Adapters.Postgres
end
