defmodule Blogex.PostsTest do
  use Blogex.DataCase

  alias Blogex.Posts
  alias Blogex.Posts.Post

  import Blogex.AccountsFixtures

  describe "posts" do
    test "list_posts/1 returns all posts" do
      scope = user_scope_fixture()

      {:ok, post1} =
        %{
          title: "Post 1",
          content: "Content 1"
        }
        |> Posts.publish_post(scope)

      {:ok, post2} =
        %{
          title: "Post 2",
          content: "Content 2"
        }
        |> Posts.publish_post(scope)

      {:ok, posts} = Posts.list_posts(scope)

      assert length(posts) == 2
      assert Enum.any?(posts, fn p -> p.title == post1.title end)
      assert Enum.any?(posts, fn p -> p.title == post2.title end)
    end

    test "publish_post/2 create new blog post" do
      scope = user_scope_fixture()

      post_attrs = %{
        title: "New Post",
        content: "This is a new blog post."
      }

      {:ok, %Post{} = post} = Posts.publish_post(post_attrs, scope)

      assert post.title == "New Post"
      assert post.content == "This is a new blog post."
      assert post.author_id == scope.user.id
    end
  end
end
