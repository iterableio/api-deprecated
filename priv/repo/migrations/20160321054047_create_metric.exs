defmodule Api.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :type, :string, null: false
      add :context, :map
      add :assets, :map
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps
    end
    create index(:metrics, [:user_id])

  end
end
