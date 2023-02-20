defmodule Ps.Repo.Migrations.CreateTweetLikes do
  use Ecto.Migration

  def change do
    create table(:tweet_likes) do
      add(:tweet_id, references(:tweets, on_delete: :delete_all))
      add(:profile_id, references(:profiles, on_delete: :delete_all))

      timestamps()
    end

    create(unique_index(:tweet_likes, [:tweet_id, :profile_id]))

    alter table(:tweets) do
      add(:likes_count, :integer, default: 0)
    end
  end
end
