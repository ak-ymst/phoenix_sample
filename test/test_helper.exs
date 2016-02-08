ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PhoenixSample.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PhoenixSample.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PhoenixSample.Repo)

