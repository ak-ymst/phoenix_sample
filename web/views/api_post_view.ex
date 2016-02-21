defmodule PhoenixSample.ApiPostView do
  use PhoenixSample.Web, :view

  def render("index.json", %{posts: posts, conn: conn}) do
    posts = posts |> Enum.map(fn(post) -> Map.merge( Map.from_struct(post), %{link: api_post_path(conn, :show, post)}) end)

    %{posts: render_many(posts, PhoenixSample.ApiPostView, "api_post_header.json")}
  end

  def render("show.json", %{api_post: api_post}) do
    render_one(api_post, PhoenixSample.ApiPostView, "api_post_body.json")
  end

  def render("api_post_header.json", %{api_post: api_post}) do
    %{id: api_post.id,
      title: api_post.title, 
      inserted_at: api_post.inserted_at,
      link: api_post.link
     }
  end

  def render("api_post_body.json", %{api_post: api_post}) do
    %{id: api_post.id,
      title: api_post.title, 
      content: api_post.content,
      inserted_at: api_post.inserted_at,
      comments: render_many(api_post.comments, PhoenixSample.ApiPostView, "comment.json")
     }
  end

  def render("comment.json", %{api_post: comment}) do
    %{id: comment.id,
      name: comment.name,
      content: comment.content,
      inserted_at: comment.inserted_at
     }
  end
end
