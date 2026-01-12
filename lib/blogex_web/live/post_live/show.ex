defmodule BlogexWeb.PostLive.Show do
  use BlogexWeb, :live_view

  alias Blogex.Posts.Post

  def mount(%{"post_id" => post_id}, _session, socket) do
    post = %Post{
      id: String.to_integer(post_id),
      title: "Post #{post_id}",
      content: "This is the body of post #{post_id}."
    }

    socket =
      socket
      |> assign(:post, post)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <div>
        {@post.title}
      </div>
    </Layouts.app>
    """
  end
end
