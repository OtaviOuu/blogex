defmodule BlogexWeb.PostLive.Show do
  use BlogexWeb, :live_view

  alias Blogex.Posts.Post
  alias Blogex.Posts

  def mount(%{"post_id" => post_id}, _session, socket) do
    {:ok, assign_post(socket, post_id)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        {@post.title}
      </.header>
      <article class="w-full max-w-3xl prose prose-lg mx-auto break-words">
        <p>{@post.content}</p>
      </article>
    </Layouts.app>
    """
  end

  defp assign_post(socket, post_id) do
    case Posts.get_post(post_id) do
      nil ->
        socket
        |> put_flash(:error, "Post not found")
        |> push_navigate(to: "/")

      %Post{} = post ->
        assign(socket, :post, post)
    end
  end
end
