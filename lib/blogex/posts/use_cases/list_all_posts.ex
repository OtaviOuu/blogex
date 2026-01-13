defmodule Blogex.Posts.UseCases.ListAllPosts do
  alias Blogex.Posts.Post

  alias Blogex.Repo

  def call do
    posts = Repo.all(Post)

    {:ok, posts}
  end
end
