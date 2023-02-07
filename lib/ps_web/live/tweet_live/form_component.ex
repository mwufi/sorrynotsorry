defmodule PsWeb.TweetLive.FormComponent do
  use PsWeb, :live_component

  alias Ps.Tweets

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage tweet records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="tweet-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :content}} type="text" label="Content" />
        <.input field={{f, :hashtags}} type="text" label="Hashtags" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Tweet</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{tweet: tweet} = assigns, socket) do
    changeset = Tweets.change_tweet(tweet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"tweet" => tweet_params}, socket) do
    changeset =
      socket.assigns.tweet
      |> Tweets.change_tweet(tweet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"tweet" => tweet_params}, socket) do
    save_tweet(socket, socket.assigns.action, tweet_params)
  end

  defp save_tweet(socket, :edit, tweet_params) do
    case Tweets.update_tweet(socket.assigns.tweet, tweet_params) do
      {:ok, _tweet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tweet updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_tweet(socket, :new, tweet_params) do
    case Tweets.create_tweet(tweet_params) do
      {:ok, _tweet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tweet created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
