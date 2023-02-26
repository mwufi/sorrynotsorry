defmodule Ps.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :description, :text
      add :color, :string

      timestamps()
    end
  end
end
