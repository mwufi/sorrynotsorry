defmodule Ps.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Chats` context.
  """

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Ps.Chats.create_chat()

    chat
  end
end
