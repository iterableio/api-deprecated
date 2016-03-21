defmodule Api.Repo.Migrations.CreateFrame do
  use Ecto.Migration

  def change do
    create table(:frames) do
      add :content, :map, null: false
      add :iteration, :integer, null: false
      add :editor, :string
      add :frame_taken, :datetime, null: false
      add :file_id, references(:files, on_delete: :delete_all), null: false

      timestamps
    end
    create index(:frames, [:file_id])

  end
end
