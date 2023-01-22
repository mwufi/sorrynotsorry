defmodule PsWeb.PageLive do
  use PsWeb, :live_view
  alias Ps.Accounts

  def mount(_params, session, socket) do
    user = if Map.has_key?(session, "user_token") do
      Accounts.get_user_by_session_token(session["user_token"])
    else
      nil
    end

    {:ok, assign(socket, current_user: user, count: 0, user_style: "
p:hover {
  color: firebrick !important;
}
", markdown_blurb: "
hi

# What's up homies

# hello there

## ok this is a real heading

<button class='px-4 py-2 border mb-4' onclick=\"alert('hi')\">Click me</button>

here is a paragaph

here is a [link to google](http://google.com)

Time went by and not enough vendors implemented the new feature (Firefox and Chrome included some experimental support), so it was eventually dropped. The browser behaviour remains as it was before HTML 5, but the current spec at least documents it: style is now legal/valid throughout the document, but the spec warns about the potential side effects (restyling elements accidentally).
    ")}
  end

  def handle_event("click", _, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end
end
