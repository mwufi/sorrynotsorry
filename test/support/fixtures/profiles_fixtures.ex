defmodule Ps.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Profiles` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        avatar_url: "some avatar_url",
        bio: "some bio",
        name: "some name",
        username: "some username"
      })
      |> Ps.Profiles.create_profile()

    profile
  end
end
