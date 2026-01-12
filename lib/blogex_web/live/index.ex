defmodule BlogexWeb.Index do
  use BlogexWeb, :live_view

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.blog_posts_list />
    </Layouts.app>
    """
  end

  def blog_posts_list(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols- gap-4">
      <.blog_post_card :for={_ <- 1..10} />
    </div>
    """
  end
end
