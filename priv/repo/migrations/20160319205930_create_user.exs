defmodule Api.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :token, :string

      timestamps
    end

  end
end
