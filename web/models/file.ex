defmodule Api.File do
  use Api.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "files" do
    field :path, :string, null: false
    field :name, :string, null: false
    belongs_to :user, Api.User

    timestamps
  end

  @required_fields ~w(path name user_id)
  @optional_fields ~w()

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
