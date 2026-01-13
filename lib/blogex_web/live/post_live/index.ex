defmodule BlogexWeb.PostLive.Index do
  use BlogexWeb, :live_view

  alias Blogex.Posts.Post
  alias Blogex.Posts

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_posts

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <%= if @posts != [] do %>
        <.blog_posts_list posts={@posts} />
      <% else %>
        <div class="text-center text-lg font-medium">
          sem posts pra vc
        </div>
      <% end %>
    </Layouts.app>
    """
  end

  defp assign_posts(socket) do
    scope = socket.assigns.current_scope

    case Posts.list_posts(scope) do
      {:ok, posts} ->
        assign(socket, :posts, posts)

      {:error, reason} ->
        socket
        |> put_flash(:error, "Failed to load posts: #{reason}")
        |> assign(:posts, [])
    end
  end

  def blog_posts_list(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols- gap-4">
      <.blog_post_card :for={post <- @posts} post={post} />
    </div>
    """
  end

  attr :post, Post, required: true

  def blog_post_card(assigns) do
    ~H"""
    <div
      class="card shadow-sm  w-full hover:bg-neutral-focus cursor-pointer"
      phx-click={JS.navigate("/posts/#{@post.id}")}
    >
      <div class="card-body">
        <h2 class="card-title">{@post.title}</h2>
        <p>
          {@post.content}
        </p>
      </div>
    </div>
    """
  end
end
