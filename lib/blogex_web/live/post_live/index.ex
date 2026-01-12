defmodule BlogexWeb.PostLive.Index do
  use BlogexWeb, :live_view

  alias Blogex.Posts.Post

  def mount(_params, _session, socket) do
    posts = [
      %Post{id: 1, title: "First Post", content: "This is the body of the first post."},
      %Post{id: 2, title: "Second Post", content: "This is the body of the second post."},
      %Post{id: 3, title: "Third Post", content: "This is the body of the third post."}
    ]

    socket =
      socket
      |> assign(:posts, posts)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.blog_posts_list posts={@posts} />
    </Layouts.app>
    """
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
