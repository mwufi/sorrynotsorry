defmodule Ps.Repo.Migrations.CreateBetterComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      remove(:submission_id)

      # at most, we allow one level of comments
      add :parent_id, references(:comments, on_delete: :delete_all)
    end

    # For polymorphic associations
    create table(:submission_comments, primary_key: false) do
      add(:comment_id, references(:comments, on_delete: :delete_all))
      add(:submission_id, references(:submissions, on_delete: :delete_all))
    end
  end
end
