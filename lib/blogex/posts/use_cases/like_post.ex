defmodule Blogex.Posts.UseCases.LikePost do
  import Ecto.Query, warn: false

  alias Blogex.Repo
  alias Blogex.Posts.Like

  def call(post_id, scope) do
    like_attrs = %{post_id: post_id}

    like_attrs
    |> Like.changeset(scope)
    |> Repo.insert()
  end
end
