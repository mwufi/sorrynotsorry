defmodule Ps.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :username, :string
      add :name, :text
      add :bio, :text
      add :avatar_url, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:profiles, [:user_id])
    create unique_index(:profiles, [:username])
  end
end
