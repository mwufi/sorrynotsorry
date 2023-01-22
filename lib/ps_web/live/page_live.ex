defmodule PsWeb.PageLive do
  use PsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0, markdown_blurb: "
hi

# What's up homies

# hello there

## ok this is a real heading

here is a paragaph

here is a [link to google](http://google.com)



    ")}
  end

  def handle_event("click", _, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end
end
