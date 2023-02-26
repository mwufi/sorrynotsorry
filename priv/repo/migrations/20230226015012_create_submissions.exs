defmodule Ps.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :name, :string
      add :body, :text
      add :link, :string
      add :author_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end

    create index(:submissions, [:author_id])
  end
end
