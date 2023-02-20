defmodule Ps.Tweets do
  @moduledoc """
  The Tweets context.
  """

  import Ecto.Query, warn: false
  alias Ps.Policy
  alias Ps.Repo

  alias Ps.Tweets.Tweet
  alias Ps.Tweets.TweetLike

  @doc """
  Returns the list of tweets.

  ## Examples

      iex> list_tweets()
      [%Tweet{}, ...]

  """
  def list_tweets do
    # order tweets by last updated
    from(c in Tweet, order_by: [desc: c.inserted_at])
    |> Repo.all()
    |> Repo.preload(:profile)
  end

  def like_tweet(tweet_id, profile) do
    tweet =
      tweet_id
      |> get_tweet!()

    result =
      tweet
      |> Ecto.build_assoc(:tweet_likes)
      |> TweetLike.changeset(%{profile_id: profile.id})
      |> Repo.insert()

    case result do
      {:ok, _} ->
        tweet
        |> Tweet.changeset(%{likes_count: tweet.likes_count + 1})
        |> Repo.update()

      {:error, _} ->
        {:error, "Already liked"}
    end
  end

  @doc """
  Gets a single tweet.

  Raises `Ecto.NoResultsError` if the Tweet does not exist.

  ## Examples

      iex> get_tweet!(123)
      %Tweet{}

      iex> get_tweet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tweet!(id), do: Repo.get!(Tweet, id)

  @doc """
  Creates a tweet.

  ## Examples

      iex> create_tweet(%{field: value})
      {:ok, %Tweet{}}

      iex> create_tweet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tweet(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a tweet for a user.

  ## Examples

      iex> create_tweet_for_user(current_user, %{field: value})
      {:ok, %Tweet{}}

      iex> create_tweet_for_user(current_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tweet_for_profile(current_profile, attrs \\ %{}) do
    with :ok <- Policy.authorize(:tweet_create, current_profile) do
      Ecto.build_assoc(current_profile, :tweets)
      |> Tweet.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a tweet.

  ## Examples

      iex> update_tweet(tweet, %{field: new_value})
      {:ok, %Tweet{}}

      iex> update_tweet(tweet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tweet(%Tweet{} = tweet, attrs) do
    tweet
    |> Tweet.changeset(attrs)
    |> Repo.update()
  end

  def update_tweet_for_profile(current_profile, %Tweet{} = tweet, attrs \\ %{}) do
    with :ok <- Policy.authorize(:tweet_update, current_profile) do
      update_tweet(tweet, attrs)
    end
  end

  @doc """
  Deletes a tweet.

  ## Examples

      iex> delete_tweet(tweet)
      {:ok, %Tweet{}}

      iex> delete_tweet(tweet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tweet(%Tweet{} = tweet) do
    Repo.delete(tweet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tweet changes.

  ## Examples

      iex> change_tweet(tweet)
      %Ecto.Changeset{data: %Tweet{}}

  """
  def change_tweet(%Tweet{} = tweet, attrs \\ %{}) do
    Tweet.changeset(tweet, attrs)
  end
end
