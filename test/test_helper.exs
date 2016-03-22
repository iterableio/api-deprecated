ExUnit.start

Code.load_file("test/controllers/controller_test_helper.exs")

Mix.Task.run "ecto.create", ~w(-r Api.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Api.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Api.Repo)

