defmodule Api.Metric do
  use Api.Web, :model

  schema "metrics" do
    field :type, :string
    field :context, :map
    field :assets, :map
    belongs_to :user, Api.User
    field :processed_at, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(type context assets user_id processed_at)
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
