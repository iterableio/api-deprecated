defmodule Api.MetricTest do
  use Api.ModelCase

  alias Api.Metric

  @valid_attrs %{type: "lines_added", assets: %{}, context: %{}, user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Metric.changeset(%Metric{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Metric.changeset(%Metric{}, @invalid_attrs)
    refute changeset.valid?
  end
end
