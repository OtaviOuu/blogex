defmodule Blogex.PostsControllerTest do
  use BlogexWeb.ConnCase

  alias Blogex.Posts
  import Blogex.AccountsFixtures

  describe "GET /api/posts" do
    test "lists all posts", %{conn: conn} do
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

      conn = get(conn, ~p"/api/posts")

      response_payload = json_response(conn, 200) |> Map.get("data")

      assert response_payload == [
               %{
                 "id" => post1.id,
                 "title" => post1.title,
                 "content" => post1.content,
                 "inserted_at" => post1.inserted_at |> NaiveDateTime.to_iso8601(),
                 "updated_at" => post1.updated_at |> NaiveDateTime.to_iso8601()
               },
               %{
                 "id" => post2.id,
                 "title" => post2.title,
                 "content" => post2.content,
                 "inserted_at" => post2.inserted_at |> NaiveDateTime.to_iso8601(),
                 "updated_at" => post2.updated_at |> NaiveDateTime.to_iso8601()
               }
             ]
    end
  end
end
