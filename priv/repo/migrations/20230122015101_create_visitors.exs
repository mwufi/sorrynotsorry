defmodule Ps.Repo.Migrations.CreateVisitors do
  use Ecto.Migration

  def change do
    create table(:visitors) do
      add :name, :string
      add :status, :text
      add :cookie, :text
      add :visit_count, :integer, default: 0
      add :last_visit, :utc_datetime
      add :first_visit, :utc_datetime, default: fragment("now()")

      timestamps()
    end
  end
end
