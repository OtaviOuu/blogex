defmodule Blogex.Posts do
  @behaviour Bodyguard.Policy

  alias Blogex.Posts.UseCases
  alias Blogex.Posts.Post
  alias Blogex.Repo
  def authorize(:list_posts, _, _), do: :ok

  def authorize(:show_post, _, _), do: :ok

  def create_post(attrs) do
    Post.changeset(attrs)
    |> Repo.insert()
  end

  def show_post(id, scope) do
    with :ok <- Bodyguard.permit(__MODULE__, :show_post, scope) do
      UseCases.ShowPost.call(id)
    end
  end

  def list_posts(scope) do
    with :ok <- Bodyguard.permit(__MODULE__, :list_posts, scope) do
      UseCases.ListAllPosts.call()
    end
  end
end
