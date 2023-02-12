defmodule Ps.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :message, :string
    belongs_to :chat, Ps.Chats.Chat
    belongs_to :creator, Ps.Profiles.Profile

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :chat_id, :creator_id])
    |> validate_required([:message, :chat_id, :creator_id])
  end
end
