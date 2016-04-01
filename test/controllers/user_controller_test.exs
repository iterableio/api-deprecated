defmodule Api.UserControllerTest do
  use Api.ConnCase

  import Api.ControllerTestHelper

  alias Api.User
  @valid_attrs %{email: "some content"}
  @invalid_attrs %{email: ""}
  @default_user %User{email: "dog@iterable.io"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "gets chosen user", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = put_auth_token(conn, user.token)
    conn = get conn, user_path(conn, :getUser, user)
    assert json_response(conn, 200)["data"] == %{"id" => user.id,
      "email" => user.email,
      "token" => user.token}
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
    conn = put_auth_token(conn, user.token)
    conn = put conn, user_path(conn, :updateUser, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = put_auth_token(conn, user.token)
    conn = put conn, user_path(conn, :updateUser, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = put_auth_token(conn, user.token)
    conn = delete conn, user_path(conn, :deleteUser, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end

  test "tries to get user without authenticating", %{conn: conn} do
    user = Repo.insert! @default_user
    conn = get conn, user_path(conn, :getUser, user)
    assert response(conn, 401)
  end

  test "tries to get user by authenticating as a different user", %{conn: conn} do
    user = Repo.insert! @default_user
    target = Repo.insert! %User{email: "cat@iterable.io"}

    conn = put_auth_token(conn, user.token)
    conn = get conn, user_path(conn, :getUser, target)
    assert response(conn, 401)
  end
end
