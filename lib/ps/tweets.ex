defmodule Ps.Tweets do
  @moduledoc """
  The Tweets context.
  """

  import Ecto.Query, warn: false
  alias Ps.Policy
  alias Ps.Repo

  alias Ps.Tweets.Tweet

  @doc """
  Returns the list of tweets.

  ## Examples

      iex> list_tweets()
      [%Tweet{}, ...]

  """
  def list_tweets do
    Repo.all(Tweet)
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
