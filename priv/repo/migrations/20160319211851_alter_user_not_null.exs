defmodule Api.Repo.Migrations.AlterUserNotNull do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string, null: false
      modify :token, :string, null: false
    end
  end
end
