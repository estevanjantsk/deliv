defmodule Deliv.Repo do
  use Ecto.Repo,
    otp_app: :deliv,
    adapter: Ecto.Adapters.Postgres
end
