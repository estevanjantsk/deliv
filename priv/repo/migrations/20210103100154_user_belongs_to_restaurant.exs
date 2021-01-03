defmodule Deliv.Repo.Migrations.UserBelongsToRestaurant do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :restaurant_id, references(:restaurants)
    end
  end
end
