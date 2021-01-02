defmodule DelivWeb.AdminController do
  use DelivWeb, :controller

  plug :put_layout, "admin.html"

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
