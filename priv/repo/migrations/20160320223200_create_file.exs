defmodule Api.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :path, :string, null: false
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps
    end
    create index(:files, [:user_id])

  end
end
