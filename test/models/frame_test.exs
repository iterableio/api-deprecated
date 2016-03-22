defmodule Api.FrameTest do
  use Api.ModelCase

  alias Api.Frame

  @valid_attrs %{content: %{}, frame_taken: "2010-04-17 14:00:00", iteration: 42, file_id: 69}
  @valid_attrs_with_optional %{content: %{}, editor: "vim", frame_taken: "2010-04-17 14:00:00", iteration: 42, file_id: 69}
  @invalid_attrs %{}

  test "changeset with valid required attributes" do
    changeset = Frame.changeset(%Frame{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with all valid attributes" do
    changeset = Frame.changeset(%Frame{}, @valid_attrs_with_optional)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Frame.changeset(%Frame{}, @invalid_attrs)
    refute changeset.valid?
  end
end
