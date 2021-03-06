defmodule PhoenixSample.Router do
  use PhoenixSample.Web, :router

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

  scope "/", PhoenixSample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/posts", PostController, expect: [:delete] do
      resources "/comments", CommentController, only: [:create]
    end
  end

  scope "/api", PhoenixSample do
    pipe_through :api

    resources "/posts", ApiPostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixSample do
  #   pipe_through :api
  # end
end
