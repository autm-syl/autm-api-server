defmodule Monsys.Repo do
  use Ecto.Repo,
    otp_app: :monsys,
    adapter: Ecto.Adapters.Postgres
end
