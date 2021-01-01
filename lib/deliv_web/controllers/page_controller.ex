defmodule DelivWeb.PageController do
  use DelivWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
