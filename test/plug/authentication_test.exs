defmodule Api.Plug.AuthenticationTest do
  use Api.ModelCase
  use Plug.Test

  alias Api.Plug.Authentication
  alias Api.User

  import Api.Plug.Util, only: [get_user: 1]

  setup do
    user = Repo.insert! %User{email: "same@iterable.io"}
    {:ok, user: user}
  end

  test "assigns correct user to conn", %{user: user} do
    conn = conn(:get, "/")
    |> put_req_header("authorization", "token #{user.token}")
    |> Authentication.call(nil)

    refute conn.halted
    refute conn.status
    assert get_user(conn) == user
  end

  test "if user doesn't exist gives 401 and halts" do
    random_token = "00000000-0000-0000-0000-000000000000"
    conn = conn(:get, "/")
    |> put_req_header("authorization", "token #{random_token}")
    |> Authentication.call(nil)

    assert conn.halted
    assert conn.status == 401
    refute get_user(conn)
  end

  test "if no auth header gives 401 and halts" do
    conn = conn(:get, "/")
    |> Authentication.call(nil)

    assert conn.halted
    assert conn.status == 401
    refute get_user(conn)
  end

  test "if auth header incorrect gives 401 and halts", %{user: user} do
    conn = conn(:get, "/")
    |> put_req_header("authorization", "yoloauth #{user.token}")
    |> Authentication.call(nil)

    assert conn.halted
    assert conn.status == 401
    refute get_user(conn)
  end
end
