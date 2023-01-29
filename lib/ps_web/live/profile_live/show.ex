defmodule PsWeb.ProfileLive.Show do
  use PsWeb, :live_view

  alias Ps.Profiles
  on_mount({PsWeb.UserAuth, :mount_current_user})

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"username" => username}, _, socket) do
    profile = Profiles.get_profile_by_username!(username)

    {:noreply,
     socket
     |> assign(:profile, profile)
     |> assign(:username, username)
     |> assign(:page_title, page_title(socket.assigns.live_action, profile))}
  end

  defp page_title(:show, profile) do
    case profile do
      nil -> "Profile not found"
      _ -> "#{profile.name} (@#{profile.username})"
    end
  end

  defp page_title(:edit, profile) do
    case profile do
      nil -> "Profile not found"
      _ -> "Edit #{profile.name} (@#{profile.username})"
    end
  end
end
