defmodule PsWeb.PageController do
  use PsWeb, :controller

  def home(conn, _params) do
    # A list of recommended profiles to follow
    render(conn, :tumblr,
      layout: false,
      tweets: Ps.Tweets.list_tweets(),
      profile_recommendations: Ps.Profiles.list_profiles()
    )
  end

  def editor(conn, _params) do
    render(conn, :editor)
  end

  def plain_html(conn, %{"page" => page}) do
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

    render(conn, "#{page}.html",
      profile: profile2,
      layout: false,
      show_header: false,
      public_posts: Ps.Posts.list_public_posts()
    )
  end

  def other(conn, _params) do
    render(conn, :hun, layout: {PsWeb.Layouts, :markdown})
  end
end
