defmodule PhoenixSample.CommentController do
  use PhoenixSample.Web, :controller

  alias PhoenixSample.Post
  alias PhoenixSample.Comment

  plug :scrub_params, "comment" when action in [:create, :update]

  def create(conn, %{"post_id" => post_id, "comment" => post_params}) do
    post = Repo.get!(Post, post_id)
    changeset = Comment.changeset(%Comment{post_id: post.id}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Comment create successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Error occured.")
        |> redirect(to: post_path(conn, :show, post))
    end
  end
end
