defmodule PsWeb.SubmissionController do
  use PsWeb, :controller

  alias Ps.Submissions
  alias Ps.Submissions.Submission

  def index(conn, _params) do
    submissions = Submissions.list_submissions()
    render(conn, :index, submissions: submissions)
  end

  def new(conn, _params) do
    changeset = Submissions.change_submission(%Submission{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    case Submissions.create_submission(submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: ~p"/submissions/#{submission}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    render(conn, :show, submission: submission)
  end

  def edit(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    changeset = Submissions.change_submission(submission)
    render(conn, :edit, submission: submission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "submission" => submission_params}) do
    submission = Submissions.get_submission!(id)

    case Submissions.update_submission(submission, submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission updated successfully.")
        |> redirect(to: ~p"/submissions/#{submission}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, submission: submission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    {:ok, _submission} = Submissions.delete_submission(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: ~p"/submissions")
  end
end
