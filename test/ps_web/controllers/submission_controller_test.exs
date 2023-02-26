defmodule PsWeb.SubmissionControllerTest do
  use PsWeb.ConnCase

  import Ps.SubmissionsFixtures

  @create_attrs %{body: "some body", link: "some link", name: "some name"}
  @update_attrs %{body: "some updated body", link: "some updated link", name: "some updated name"}
  @invalid_attrs %{body: nil, link: nil, name: nil}

  describe "index" do
    test "lists all submissions", %{conn: conn} do
      conn = get(conn, ~p"/submissions")
      assert html_response(conn, 200) =~ "Listing Submissions"
    end
  end

  describe "new submission" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/submissions/new")
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "create submission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/submissions", submission: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/submissions/#{id}"

      conn = get(conn, ~p"/submissions/#{id}")
      assert html_response(conn, 200) =~ "Submission #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/submissions", submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "edit submission" do
    setup [:create_submission]

    test "renders form for editing chosen submission", %{conn: conn, submission: submission} do
      conn = get(conn, ~p"/submissions/#{submission}/edit")
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "update submission" do
    setup [:create_submission]

    test "redirects when data is valid", %{conn: conn, submission: submission} do
      conn = put(conn, ~p"/submissions/#{submission}", submission: @update_attrs)
      assert redirected_to(conn) == ~p"/submissions/#{submission}"

      conn = get(conn, ~p"/submissions/#{submission}")
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, submission: submission} do
      conn = put(conn, ~p"/submissions/#{submission}", submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "delete submission" do
    setup [:create_submission]

    test "deletes chosen submission", %{conn: conn, submission: submission} do
      conn = delete(conn, ~p"/submissions/#{submission}")
      assert redirected_to(conn) == ~p"/submissions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/submissions/#{submission}")
      end
    end
  end

  defp create_submission(_) do
    submission = submission_fixture()
    %{submission: submission}
  end
end
