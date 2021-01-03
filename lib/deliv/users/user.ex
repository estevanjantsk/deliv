defmodule Deliv.Users.User do
  use Deliv.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :role, :string, null: false, default: "client"

    pow_user_fields()

    timestamps()

    belongs_to :restaurant, Deliv.Admin.Restaurant
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(main admin employee cashier client))
  end
end
