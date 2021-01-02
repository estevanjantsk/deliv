defmodule Deliv.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add :name, :string
      add :cnpj, :string
      add :phone, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:restaurants, [:cnpj])
  end
end
