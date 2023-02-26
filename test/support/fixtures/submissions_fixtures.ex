defmodule Ps.SubmissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ps.Submissions` context.
  """

  @doc """
  Generate a submission.
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        body: "some body",
        link: "some link",
        name: "some name"
      })
      |> Ps.Submissions.create_submission()

    submission
  end
end
