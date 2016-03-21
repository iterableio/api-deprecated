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

  test "read and write" do
    user = Repo.insert! %Api.User{email: "yolo@swag.org"}
    file = Repo.insert! %Api.File{name: "a", path: "b", user_id: user.id}
    frame = Repo.insert! %Api.Frame{content: %{"a": "b"}, editor: "vim", frame_taken: Ecto.DateTime.utc(), iteration: 0, file_id: file.id}
    frame = Repo.preload frame, :file
    IO.inspect frame
  end
end
