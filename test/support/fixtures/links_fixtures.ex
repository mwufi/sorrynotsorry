defmodule Ps.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        click_count: 42,
        href: "some href",
        name: "some name"
      })
      |> Ps.Links.create_link()

    link
  end
end
