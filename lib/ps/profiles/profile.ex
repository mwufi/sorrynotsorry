defmodule Ps.Profiles.Profile do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  alias Ps.Avatar

  schema "profiles" do
    field(:avatar_url, :string,
      default: "https://avatars.githubusercontent.com/u/12648958?s=200&v=4"
    )

    field(:bio, :string, default: "I am a new user")
    field(:name, :string)
    field(:username, :string)
    field(:header_img_url, Avatar.Type)
    belongs_to(:user, Ps.Accounts.User)

    has_many(:tweets, Ps.Tweets.Tweet)

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:username, :name, :bio, :avatar_url])
    |> cast_attachments(attrs, [:header_img_url])
    |> validate_username()
    |> validate_required([:username, :name, :bio, :avatar_url])
  end

  @doc """
  Changeset for registration.
  """
  def registration_changeset(profile, attrs) do
    profile
    |> cast(attrs, [:username])
    |> validate_username()
    |> validate_required([:username])
  end

  def validate_username(changeset, _opts \\ []) do
    changeset
    |> validate_format(:username, ~r/^[a-zA-Z0-9\.]*$/)
    |> unsafe_validate_unique(:username, Ps.Repo)
    |> unique_constraint(:username)
  end
end
