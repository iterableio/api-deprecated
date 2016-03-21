defmodule Api.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :context, :map, null: false
      add :assets, :map, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :processed_at, :datetime, null: false

      timestamps
    end
    create index(:metrics, [:user_id])

  end
end
