use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_sample, PhoenixSample.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_sample, PhoenixSample.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "phoenix",
  password: "phoenix",
  database: "phoenix_sample_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
