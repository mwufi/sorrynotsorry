defmodule Ps.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :content, :text
      add :hashtags, :text
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end

    create index(:tweets, [:profile_id])
  end
end
