defmodule PsWeb.PageController do
  use PsWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def other(conn, _params) do
    render(conn, :hun, layout: {PsWeb.Layouts, :markdown})
  end
end
