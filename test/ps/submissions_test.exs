defmodule Ps.SubmissionsTest do
  use Ps.DataCase

  alias Ps.Submissions

  describe "submissions" do
    alias Ps.Submissions.Submission

    import Ps.SubmissionsFixtures

    @invalid_attrs %{body: nil, link: nil, name: nil}

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Submissions.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Submissions.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      valid_attrs = %{body: "some body", link: "some link", name: "some name"}

      assert {:ok, %Submission{} = submission} = Submissions.create_submission(valid_attrs)
      assert submission.body == "some body"
      assert submission.link == "some link"
      assert submission.name == "some name"
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Submissions.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      update_attrs = %{body: "some updated body", link: "some updated link", name: "some updated name"}

      assert {:ok, %Submission{} = submission} = Submissions.update_submission(submission, update_attrs)
      assert submission.body == "some updated body"
      assert submission.link == "some updated link"
      assert submission.name == "some updated name"
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Submissions.update_submission(submission, @invalid_attrs)
      assert submission == Submissions.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Submissions.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Submissions.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Submissions.change_submission(submission)
    end
  end
end
