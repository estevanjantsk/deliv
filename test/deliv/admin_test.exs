defmodule Deliv.AdminTest do
  use Deliv.DataCase

  alias Deliv.Admin

  describe "restaurants" do
    alias Deliv.Admin.Restaurant

    @valid_attrs %{address: "some address", cnpj: "some cnpj", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", cnpj: "some updated cnpj", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, cnpj: nil, name: nil, phone: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Admin.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Admin.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Admin.create_restaurant(@valid_attrs)
      assert restaurant.address == "some address"
      assert restaurant.cnpj == "some cnpj"
      assert restaurant.name == "some name"
      assert restaurant.phone == "some phone"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{} = restaurant} = Admin.update_restaurant(restaurant, @update_attrs)
      assert restaurant.address == "some updated address"
      assert restaurant.cnpj == "some updated cnpj"
      assert restaurant.name == "some updated name"
      assert restaurant.phone == "some updated phone"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_restaurant(restaurant, @invalid_attrs)
      assert restaurant == Admin.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Admin.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Admin.change_restaurant(restaurant)
    end
  end
end
