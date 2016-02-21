defmodule PhoenixSample.ApiPostController do
  use PhoenixSample.Web, :controller

  alias PhoenixSample.Post

  plug :scrub_params, "api_post" when action in [:create, :update]

  def index(conn, _params) do
    posts = Repo.all(Post) 
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"api_post" => api_post_params}) do
    changeset = Post.changeset(%Post{}, api_post_params)

    case Repo.insert(changeset) do
      {:ok, api_post} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_post_path(conn, :show, api_post))
        |> render("show.json", api_post: api_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixSample.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    api_post = Repo.get!(Post, id) |> Repo.preload(:comments)
    render(conn, "show.json", api_post: api_post)
  end

  def update(conn, %{"id" => id, "api_post" => api_post_params}) do
    api_post = Repo.get!(Post, id)
    changeset = Post.changeset(api_post, api_post_params)

    case Repo.update(changeset) do
      {:ok, api_post} ->
        render(conn, "show.json", api_post: api_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixSample.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    api_post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).

    Repo.delete!(api_post)

    send_resp(conn, :no_content, "")
  end
end
