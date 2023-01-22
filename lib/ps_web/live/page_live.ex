defmodule PsWeb.PageLive do
  use PsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("click", _, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end

end
