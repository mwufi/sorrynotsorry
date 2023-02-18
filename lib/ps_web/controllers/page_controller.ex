defmodule PsWeb.PageController do
  use PsWeb, :controller

  def home(conn, _params) do
    # A list of recommended profiles to follow
    render(conn, :twitter,
      layout: false,
      tweets: Ps.Tweets.list_tweets(),
      profile_recommendations: Ps.Profiles.list_profiles()
    )
  end

  def editor(conn, _params) do
    render(conn, :editor)
  end

  def plain_html(conn, %{"page" => page}) do
    render(conn, "#{page}.html",
      profile: Ps.Profiles.random_profile(),
      layout: false,
      show_header: false,
      public_posts: Ps.Posts.list_public_posts(),
      chats: Ps.SampleData.chats()
    )
  end

  def other(conn, _params) do
    render(conn, :hun, layout: {PsWeb.Layouts, :markdown})
  end
end
