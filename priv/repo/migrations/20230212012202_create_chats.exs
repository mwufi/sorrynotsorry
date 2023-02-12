defmodule Ps.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :title, :text
      add :description, :text
      add :creator_id, references(:profiles, on_delete: :delete_all)

      timestamps()
    end

    create index(:chats, [:creator_id])
  end
end
