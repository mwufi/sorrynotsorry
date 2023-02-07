defmodule Ps.TweetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Tweets` context.
  """

  @doc """
  Generate a tweet.
  """
  def tweet_fixture(attrs \\ %{}) do
    {:ok, tweet} =
      attrs
      |> Enum.into(%{
        content: "some content",
        hashtags: "some hashtags"
      })
      |> Ps.Tweets.create_tweet()

    tweet
  end
end
