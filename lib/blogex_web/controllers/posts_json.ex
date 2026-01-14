defmodule BlogexWeb.PostsJSON do
  alias Blogex.Posts.Post

  def list_posts(%{posts: posts}) do
    %{
      data: Enum.map(posts, &data/1)
    }
  end

  defp data(%Post{} = post) do
    %{
      id: post.id,
      title: post.title,
      content: post.content,
      inserted_at: post.inserted_at,
      updated_at: post.updated_at
    }
  end
end
