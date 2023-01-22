defmodule Ps.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :is_draft, :boolean, default: true
    field :subtitle, :string
    field :title, :string

    belongs_to :author, Ps.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :title, :subtitle, :is_draft, :author_id])
    |> validate_required([:content, :title, :subtitle, :is_draft, :author_id])
  end
end
