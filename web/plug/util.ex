defmodule Api.Plug.Util do
  import Plug.Conn, only: [assign: 3]

  alias Plug.Conn
  alias Api.User

  def set_user(conn, user) do
    assign(conn, :user, user)
  end

  def get_user(conn) do
    conn.assigns[:user]
  end
end

