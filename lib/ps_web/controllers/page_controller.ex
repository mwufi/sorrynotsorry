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
    render(conn, :inbox,
      layout: false,
      public_posts: Ps.Posts.list_public_posts(),
      message: message
    )
  end

  def editor(conn, _params) do
    render(conn, :editor)
  end

  def github(conn, _params) do
    render(conn, :github)
  end

  def profile(conn, _params) do
    profile = %{
      name: "John Doe",
      byline: "",
      bio:
        "I sit at the intersection of design, anthropology, and programming. These three are at the core of everything I make. Combining them into a coherent career is a weird and ongoing challenge.

      Titles and disciplines are fickle and fleeting. But my work fits under the umbrellas of UX design, visual interface design, and DX (developer experience). With some cultural analysis, writing, and visual illustration sprinkled on top.

      I currently lead design atOughtwhere we're exploring how machine learning can help researchers with open-ended reasoning.",
      avatar: "https://avatars.githubusercontent.com/u/30219253?v=4",
      links: [
        %{name: "Twitter", url: "https://twitter.com/"},
        %{name: "GitHub", url: ""},
        %{name: "Website", url: "https://johndoe.com"}
      ]
    }

    profile2 = %{
      name: "Jane Doe",
      byline:
        "(If it was easy, everyone would do it) Greetings, peoples. Welcome to the blog of all the fun things. Here be comics, Pratchett, vaguely-Middle-Ages-related things, Avengers, angry feminism, all the book-love and a chocolate biscuit. Now proud owner of a one starship fleet known as My Starship Now
      Enjoy.",
      bio:
        "I sit at the intersection of design, anthropology, and programming. These three are at the core of everything I make. Combining them into a coherent career is a weird and ongoing challenge.
        ",
      avatar: "https://avatars.githubusercontent.com/u/30219253?v=4"
    }

    render(conn, :profile,
      profile: profile2,
      layout: false,
      public_posts: Ps.Posts.list_public_posts()
    )
  end

  def other(conn, _params) do
    render(conn, :hun, layout: {PsWeb.Layouts, :markdown})
  end
end
