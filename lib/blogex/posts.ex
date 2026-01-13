defmodule Blogex.Posts do
  @behaviour Bodyguard.Policy

  alias Blogex.Posts.UseCases
  alias Blogex.Posts.Post
  alias Blogex.Repo
  def authorize(:list_posts, _, _), do: :ok

  def authorize(:show_post, _, _), do: :ok

  def authorize(:publish_post, _, _), do: :ok

  def publish_post(attrs, scope) do
    with :ok <- Bodyguard.permit(__MODULE__, :publish_post, scope) do
      UseCases.PublishPost.call(attrs, scope)
    end
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

  def post_changeset(attrs, scope) do
    Post.changeset(attrs, scope)
  end
end
