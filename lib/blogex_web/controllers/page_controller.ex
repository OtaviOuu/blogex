defmodule BlogexWeb.PageController do
  use BlogexWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/posts")
  end
end
