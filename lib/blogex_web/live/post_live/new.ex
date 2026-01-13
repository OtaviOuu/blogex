defmodule BlogexWeb.PostLive.New do
  use BlogexWeb, :live_view

  on_mount {BlogexWeb.UserAuth, :require_admin}

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        New Post
      </.header>
      <p>This is the new post page.</p>
    </Layouts.app>
    """
  end
end
