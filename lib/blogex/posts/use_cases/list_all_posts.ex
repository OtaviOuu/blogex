defmodule Blogex.Posts.UseCases.ListAllPosts do
  alias Blogex.Posts.Post

  alias Blogex.Repo
  import Ecto.Query, warn: false

  def call do
    posts =
      post_query()
      |> Post.calculate_like_count()
      |> Repo.all()

    {:ok, posts}
  end

  defp post_query do
    from p in Post, as: :post
  end
end
