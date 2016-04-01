defmodule Api.Plug.Authentication do
  @behaviour Plug

  import Plug.Conn
  import Api.Plug.Util, only: [set_user: 2]

  alias Api.Repo
  alias Api.User

  def init(_) do
    nil
  end

  def call(conn, _) do
    case conn |> extract_token |> user_from_token do
      %User{}=user ->
        conn
        |> set_user(user)
      nil ->
        conn
        |> resp(401, "")
        |> halt
    end
  end

  # We expect a header `Authorization: token $TOKEN`
  defp extract_token(conn) do
    case get_req_header(conn, "authorization") do
      [value] ->
        case String.split(value) do
          ["token", token] -> token
          _ -> nil
        end
      [] -> nil
    end
  end

  defp user_from_token(nil), do: nil
  defp user_from_token(token) do
    Repo.get_by(User, token: token)
  end
end
