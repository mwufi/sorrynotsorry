defmodule Ps.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :content, :string
    field :hashtags, :string

    belongs_to :profile, Ps.Profiles.Profile

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:content, :hashtags])
    |> validate_required([:content])
  end
end
