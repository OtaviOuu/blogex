defmodule Blogex.Posts.UseCases.PublishPost do
  alias Blogex.Repo
  alias Blogex.Posts.Post

  def call(post_attrs, scope) do
    post_attrs
    |> Post.changeset(scope)
    |> Repo.insert()
  end
end
