defmodule Ps.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :submission_id, references(:submissions, on_delete: :delete_all)
      add :author_id, references(:profiles, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:submission_id])
    create index(:comments, [:author_id])
  end
end
