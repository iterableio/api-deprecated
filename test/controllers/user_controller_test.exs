defmodule Api.UserControllerTest do
  use Api.ConnCase

  alias Api.User
  @valid_attrs %{email: "some content"}
  @invalid_attrs %{email: ""}
  @default_user %User{email: "dog@iterable.io"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "gets chosen user", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = get conn, user_path(conn, :getUser, user)
    assert json_response(conn, 200)["data"] == %{"id" => user.id,
      "email" => user.email,
      "token" => user.token}
  end

  test "does not get user and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :getUser, -1)
    end
  end

  test "creates and renders user when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :createUser), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :createUser), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen user when data is valid", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = put conn, user_path(conn, :updateUser, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = put conn, user_path(conn, :updateUser, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = delete conn, user_path(conn, :deleteUser, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end
