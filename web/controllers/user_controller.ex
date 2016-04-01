defmodule Api.UserController do
  use Api.Web, :controller

  import Api.Plug.Util, only: [get_user: 1]

  alias Api.User

  plug Api.Plug.Authentication when action in [:getUser, :updateUser, :deleteUser]

  plug :scrub_params, "user" when action in [:createUser, :updateUser]

  def createUser(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :getUser, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Api.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def getUser(conn, %{"id" => id}) do
    current_user = get_user(conn)

    case Repo.get(User, id) do
      target when target === current_user ->
        render(conn, "show.json", user: target)
      _ ->
        conn
        |> resp(401, "")
        |> halt
    end
  end

  def updateUser(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Api.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def deleteUser(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end
end
