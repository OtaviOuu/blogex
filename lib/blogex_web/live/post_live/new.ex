defmodule BlogexWeb.PostLive.New do
  use BlogexWeb, :live_view

  on_mount {BlogexWeb.UserAuth, :require_admin}

  alias Blogex.Posts

  def mount(_params, _session, socket) do
    scope = socket.assigns.current_scope

    publish_post_form = Posts.post_changeset(%{}, scope) |> to_form(as: :post_form)

    {:ok,
     socket
     |> assign(:publish_post_form, publish_post_form)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        New Post
      </.header>
      <p>This is the new post page.</p>

      <.form for={@publish_post_form} phx-submit="save_post" class="space-y-4">
        <.input
          type="text"
          field={@publish_post_form[:title]}
          label="Title"
          placeholder="Enter post title"
          required
        />
        <.input
          type="textarea"
          field={@publish_post_form[:content]}
          label="Body"
          placeholder="Enter post body"
          required
        />
        <.button class="btn btn-neural">
          Publish Post
        </.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("save_post", %{"post_form" => post_attrs}, socket) do
    scope = socket.assigns.current_scope

    case Posts.publish_post(post_attrs, scope) do
      {:ok, post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post created successfully.")
         |> push_navigate(to: ~p"/posts/#{post.id}")}

      {:error, changeset} ->
        publish_post_form = to_form(changeset, as: :post_form, action: :validate)

        {:noreply,
         socket
         |> assign(:publish_post_form, publish_post_form)}
    end
  end
end
