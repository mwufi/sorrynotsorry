defmodule Ps.LogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Logs` context.
  """

  @doc """
  Generate a visitor.
  """
  def visitor_fixture(attrs \\ %{}) do
    {:ok, visitor} =
      attrs
      |> Enum.into(%{
        cookie: "some cookie",
        first_visit: ~U[2023-01-21 01:51:00Z],
        last_visit: ~U[2023-01-21 01:51:00Z],
        name: "some name",
        status: "some status",
        visit_count: 42
      })
      |> Ps.Logs.create_visitor()

    visitor
  end
end
