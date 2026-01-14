defmodule BlogexWeb.PostsController do
  use BlogexWeb, :controller

  action_fallback BlogexWeb.FallbackController

  alias Blogex.Posts

  def list_posts(conn, _params) do
    with {:ok, posts} <- Posts.list_posts(%{}) do
      conn
      |> put_status(:ok)
      |> render(:list_posts, posts: posts)
    end
  end
end
