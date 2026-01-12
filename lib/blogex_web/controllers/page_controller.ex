defmodule BlogexWeb.PageController do
  use BlogexWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
