defmodule Ps.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :avatar_url, :string, default: "https://avatars.githubusercontent.com/u/12648958?s=200&v=4"
    field :bio, :string, default: "I am a new user"
    field :name, :string
    field :username, :string
    belongs_to :user, Ps.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:username, :name, :bio, :avatar_url])
    |> validate_required([:username, :name, :bio, :avatar_url])
  end
end
