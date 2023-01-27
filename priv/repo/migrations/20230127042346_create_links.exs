defmodule Ps.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :name, :text
      add :href, :text
      add :click_count, :integer
      add :profile_id, references(:profiles, on_delete: :delete_all)

      timestamps()
    end

    create index(:links, [:profile_id])
  end
end
