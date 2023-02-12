defmodule Ps.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :description, :string
    field :title, :string
    belongs_to :creator, Ps.Profiles.Profile

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:title, :description, :creator_id])
    |> validate_required([:title, :description, :creator_id])
  end
end
