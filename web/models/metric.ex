defmodule Api.Metric do
  use Api.Web, :model

  schema "metrics" do
    field :context, :map
    field :assets, :map
    belongs_to :user, Api.User

    timestamps
  end

  @required_fields ~w(context assets user_id)
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
