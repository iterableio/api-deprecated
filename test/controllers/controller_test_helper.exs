defmodule Api.ControllerTestHelper do
  use Api.ConnCase

  def put_auth_token(conn, token) do
    put_req_header(conn, "authorization", "token " <> token)
  end
end
