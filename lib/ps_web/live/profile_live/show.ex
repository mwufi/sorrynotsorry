defmodule PsWeb.ProfileLive.Show do
  use PsWeb, :live_view

  alias Ps.Profiles

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"username" => username}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:profile, Profiles.get_profile_by_username!(username))}
  end

  defp page_title(:show), do: "Show Profile"
  defp page_title(:edit), do: "Edit Profile"
end
