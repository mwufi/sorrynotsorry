defmodule Ps.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :text
      add :title, :text
      add :subtitle, :text
      add :is_draft, :boolean, default: false, null: false
      add :author_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:author_id])
  end
end
