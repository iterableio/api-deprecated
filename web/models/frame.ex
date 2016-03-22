defmodule Api.Frame do
  use Api.Web, :model

  schema "frames" do
    field :content, :map
    field :iteration, :integer
    field :editor, :string
    field :frame_taken, Ecto.DateTime
    belongs_to :file, Api.File

    timestamps
  end

  @required_fields ~w(content iteration frame_taken file_id)
  @optional_fields ~w(editor)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
