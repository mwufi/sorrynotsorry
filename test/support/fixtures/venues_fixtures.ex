defmodule Ps.VenuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Venues` context.
  """

  @doc """
  Generate a venue.
  """
  def venue_fixture(attrs \\ %{}) do
    {:ok, venue} =
      attrs
      |> Enum.into(%{
        color: "some color",
        description: "some description",
        name: "some name"
      })
      |> Ps.Venues.create_venue()

    venue
  end
end
