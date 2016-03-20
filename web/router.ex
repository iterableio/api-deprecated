defmodule Api.Router do
  use Api.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", Api do
    pipe_through :api

    get "/", IndexController, :show

    scope "/users" do
      get    "/:id", UserController, :getUser
      post   "/",    UserController, :createUser
      put    "/:id", UserController, :updateUser
      delete "/:id", UserController, :deleteUser
    end
  end
end
