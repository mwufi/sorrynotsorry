defmodule Ps.Repo.Migrations.CreatePostPermalinks do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :permalink, :string
    end

    create unique_index(:posts, [:permalink])
  end
end
