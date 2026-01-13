defmodule Blogex.PostsTest do
  use Blogex.DataCase

  alias Blogex.Posts
  alias Blogex.Posts.Post

  import Blogex.AccountsFixtures

  describe "posts" do
    test "list_posts/1 returns all posts" do
      user = user_fixture()

      {:ok, post1} =
        %{
          title: "Post 1",
          content: "Content 1",
          author_id: user.id
        }
        |> Posts.create_post()

      {:ok, post2} =
        %{
          title: "Post 2",
          content: "Content 2",
          author_id: user.id
        }
        |> Posts.create_post()

      {:ok, posts} = Posts.list_posts(user)

      assert length(posts) == 2
      assert Enum.any?(posts, fn p -> p.title == "Post 1" end)
      assert Enum.any?(posts, fn p -> p.title == "Post 2" end)
    end
  end
end
