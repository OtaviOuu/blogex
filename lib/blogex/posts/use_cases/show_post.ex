defmodule Blogex.Posts.UseCases.ShowPost do
  alias Blogex.Repo
  alias Blogex.Posts.{Post}
  alias Ecto.UUID
  import Ecto.Query, warn: false

  def call(post_id) do
    case UUID.cast(post_id) do
      {:ok, uuid} -> {:ok, fetch_post(uuid)}
      :error -> {:error, :invalid_uuid}
    end
  end

  defp fetch_post(uuid) do
    uuid
    |> Post.get_by_id()
    |> Post.calculate_like_count()
    |> Repo.one()
  end
end
