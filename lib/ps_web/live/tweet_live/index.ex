defmodule PsWeb.TweetLive.Index do
  use PsWeb, :live_view

  alias Ps.Tweets
  alias Ps.Tweets.Tweet
  on_mount({PsWeb.UserAuth, :mount_current_user})

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       tweets: list_tweets(),
       public_posts: Ps.Posts.list_public_posts(),
       profile_recommendations: Ps.Profiles.list_profiles()
     )}
  end

  def handle_event("like", %{"id" => tweet_id}, socket) do
    case socket.assigns.current_user do
      nil ->
        {:noreply,
         socket
         |> put_flash(:info, "You must be logged in to like a tweet.")
         |> redirect(to: ~p"/users/log_in")}

      _ ->
        Tweets.like_tweet(tweet_id, socket.assigns.current_user.primary_profile)

        # assign tweets again?
        {:noreply, assign(socket, tweets: list_tweets())}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tweet")
    |> assign(:tweet, Tweets.get_tweet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tweet")
    |> assign(:tweet, %Tweet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tweets")
    |> assign(:tweet, %Tweet{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tweet = Tweets.get_tweet!(id)
    {:ok, _} = Tweets.delete_tweet(tweet)

    {:noreply, assign(socket, :tweets, list_tweets())}
  end

  defp list_tweets do
    Tweets.list_tweets()
  end
end
