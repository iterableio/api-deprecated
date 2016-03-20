defmodule Api.Repo.Migrations.UserTokenUuid do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :token
      add :token, :uuid, null: false
    end
    create index(:users, [:email], unique: true)
  end
end
