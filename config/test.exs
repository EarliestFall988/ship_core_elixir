import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ship_core, ShipCore.Repo,
  username: "postgres",
  password: "ac2ac356-1fb4-4304-80cf-a111bc1d2a45",
  hostname: "172.17.0.3",
  database: "ship_core_dev_test",
  stacktrace: true,
  port: "5432",
  # database: "ship_core_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ship_core, ShipCoreWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RjRBWcqLj3lCOGXLa4lnUccIQQ71IoVNVCGjoGhkgyGcKZIPoYp9wKXLcI4ADytj",
  server: false

# In test we don't send emails.
config :ship_core, ShipCore.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
