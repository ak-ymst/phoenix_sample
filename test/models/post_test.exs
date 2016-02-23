defmodule PhoenixSample.PostTest do
  use PhoenixSample.ModelCase
  use EctoFixtures

  alias PhoenixSample.Post

  @valid_attrs %{content: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  @tag fixtures: :posts
  test "get truncated content", %{data: data} do
    post = Repo.get!(Post, data.posts.long.id)
    assert Post.truncate(post.content) == "この記事は10文字以..."
  end

  @tag fixtures: :posts
  test "get not truncated content", %{data: data} do
    post = Repo.get!(Post, data.posts.short.id)
    assert Post.truncate(post.content) == "この記事は8文字"
  end
end
