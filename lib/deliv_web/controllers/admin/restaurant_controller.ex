defmodule DelivWeb.Admin.RestaurantController do
  use DelivWeb, :controller

  alias Deliv.Admin

  def edit(conn, %{"id" => id}) do
    restaurant = Admin.get_restaurant!(id)
    changeset = Admin.change_restaurant(restaurant)
    render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Admin.get_restaurant!(id)

    case Admin.update_restaurant(restaurant, restaurant_params) do
      {:ok, restaurant} ->
        conn
        |> put_flash(:info, "Restaurant updated successfully.")
        |> redirect(to: Routes.admin_restaurant_path(conn, :edit, restaurant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
    end
  end
end
