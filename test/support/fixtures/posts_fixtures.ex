defmodule Ps.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        is_draft: true,
        subtitle: "some subtitle",
        title: "some title"
      })
      |> Ps.Posts.create_post()

    post
  end
end
