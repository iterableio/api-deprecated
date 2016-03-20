defmodule Api.Repo.Migrations.CreateFile do
  use Ecto.Migration

  def change do
    create table(:files, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :path, :string, null: false
      add :name, :string, null: false
      add :user_id, references(:users), null: false

      timestamps
    end

  end
end
