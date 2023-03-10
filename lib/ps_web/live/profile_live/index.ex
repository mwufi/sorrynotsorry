defmodule PsWeb.ProfileLive.Index do
  use PsWeb, :live_view

  alias Ps.Profiles
  alias Ps.Profiles.Profile
  on_mount({PsWeb.UserAuth, :mount_current_user})

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, profiles: list_profiles(), page_title: "Click Friends")}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"username" => username}) do
    socket
    |> assign(:page_title, "Edit Profile")
    |> assign(:profile, Profiles.get_profile_by_username!(username))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Profile")
    |> assign(:profile, %Profile{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Click Friends")
    |> assign(:profile, nil)
  end

  @impl true
  def handle_event("delete", %{"username" => username}, socket) do
    profile = Profiles.get_profile_by_username!(username)

    case Profiles.delete_profile_for_user(profile, socket.assigns.current_user) do
      {:ok, _} ->
        {:noreply, assign(socket, :profiles, list_profiles())}

      {:error, :unauthorized} ->
        IO.puts("You are not authorized to delete this profile")
        {:noreply, assign(socket, :profiles, list_profiles())}

      _ ->
        {:noreply, assign(socket, :profiles, list_profiles())}
    end
  end

  defp list_profiles do
    Profiles.list_profiles()
  end
end
