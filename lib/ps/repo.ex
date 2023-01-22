defmodule Ps.Repo do
  use Ecto.Repo,
    otp_app: :ps,
    adapter: Ecto.Adapters.Postgres
end
