defmodule Deliv.Admin.Restaurant do
  use Deliv.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :address, :string
    field :cnpj, :string
    field :name, :string
    field :phone, :string

    timestamps()

    has_many :users, Deliv.Users.User
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :cnpj, :phone, :address])
    |> validate_required([:name, :cnpj, :phone, :address])
    |> unique_constraint(:cnpj)
  end
end
