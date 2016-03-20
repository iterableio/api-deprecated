defmodule Api.User do
  use Api.Web, :model

  schema "users" do
    field :email, :string
    field :token, Ecto.UUID, default: Ecto.UUID.generate()

    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w(token)

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
