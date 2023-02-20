defmodule Ps.Tweets.TweetLike do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweet_likes" do
    belongs_to(:tweet, Ps.Tweets.Tweet)
    belongs_to(:profile, Ps.Profiles.Profile)

    timestamps()
  end

  def changeset(tweet_like, attrs) do
    tweet_like
    |> cast(attrs, [:profile_id, :tweet_id])
    |> unsafe_validate_unique([:profile_id, :tweet_id], Ps.Repo)
    |> unique_constraint([:profile_id, :tweet_id])
  end
end
