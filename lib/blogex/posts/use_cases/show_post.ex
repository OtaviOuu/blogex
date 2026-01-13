defmodule Blogex.Posts.UseCases.ShowPost do
  alias Blogex.Repo
  alias Blogex.Posts.{Post}
  alias Ecto.UUID

  def call(post_id) do
    case UUID.cast(post_id) do
      {:ok, uuid} -> {:ok, fetch_post(uuid)}
      :error -> {:error, :invalid_uuid}
    end
  end

  defp fetch_post(uuid) do
    Repo.get_by(Post, id: uuid)
  end
end
