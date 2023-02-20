defmodule Ps.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :content, :string
    field :hashtags, :string
    field :likes_count, :integer, default: 0

    belongs_to :profile, Ps.Profiles.Profile

    has_many :tweet_likes, Ps.Tweets.TweetLike, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:content, :hashtags, :likes_count])
    |> validate_required([:content])
  end
end
