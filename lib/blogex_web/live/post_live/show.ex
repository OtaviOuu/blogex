defmodule BlogexWeb.PostLive.Show do
  use BlogexWeb, :live_view

  alias Blogex.Posts.Post
  alias Blogex.Posts
  alias Ecto.Changeset

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
      <div class="flex p-6 gap-4">
        <.button phx-click="do_like" class="btn btn-neutral btn-outline">
          <.icon name="hero-hand-thumb-up" /> {@post.likes_count}
        </.button>
        <.button class="btn btn-neutral btn-outline">
          <.icon name="hero-hand-thumb-down" />
        </.button>
      </div>
    </Layouts.app>
    """
  end

  defp assign_post(socket, post_id) do
    scope = socket.assigns.current_scope

    case Posts.show_post(post_id, scope) do
      {:ok, %Post{} = post} ->
        assign(socket, :post, post)

      _ ->
        socket
        |> put_flash(:error, "Post not found.")
        |> push_navigate(to: ~p"/posts")
    end
  end

  def handle_event("do_like", _params, socket) do
    scope = socket.assigns.current_scope
    post = socket.assigns.post

    case Posts.like_post(post.id, scope) do
      {:ok, %Posts.Like{} = like} ->
        socket =
          socket
          |> update(:post, fn post -> Map.update(post, :likes_count, 0, &(&1 + 1)) end)

        {:noreply, socket}

      {:error, %Changeset{} = like_changeset} ->
        {:noreply,
         socket
         |> put_flash(
           :error,
           "Unable to like the post. Please try again: #{inspect(like_changeset.errors)}"
         )}

      {:error, :not_authenticated} ->
        {:noreply,
         socket
         |> put_flash(:error, "You need to be logged in to like posts.")
         |> push_navigate(to: ~p"/users/log-in")}
    end
  end
end
