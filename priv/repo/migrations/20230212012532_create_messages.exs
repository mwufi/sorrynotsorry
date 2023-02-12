defmodule Ps.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :text
      add :creator_id, references(:profiles, on_delete: :delete_all)
      add :chat_id, references(:chats, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:chat_id])
  end
end
