defmodule Blogex.Posts do
  alias Blogex.Posts.Post

  alias Blogex.Repo

  def get_post(id) do
    with {:ok, uuid} <- Ecto.UUID.cast(id) do
      Repo.get_by(Post, id: uuid)
    else
      _ -> nil
    end
  end

  def list_posts do
    Post
    |> Repo.all()
  end
end
