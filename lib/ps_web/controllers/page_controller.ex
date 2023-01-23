defmodule PsWeb.PageController do
  use PsWeb, :controller

  def home(conn, _params) do
    welcome_text =
      "Have you ever wanted your site to feel like a live space, with music, and chat with people visiting your site? Or send out newsletters? Well, now you can! Make your home. With Bird, you can make a personal site that feels like a home, with music, chat, and more!"

    message =
      case conn.assigns[:current_user] do
        nil -> welcome_text
        _ -> "If you don't have any posts, you can create one on the editor page."
      end

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      public_posts: Ps.Posts.list_public_posts(),
      message: message
    )
  end

  def editor(conn, _params) do
    render(conn, :editor)
  end

  def other(conn, _params) do
    render(conn, :hun, layout: {PsWeb.Layouts, :markdown})
  end
end
