defmodule PsWeb.VenueControllerTest do
  use PsWeb.ConnCase

  import Ps.VenuesFixtures

  @create_attrs %{color: "some color", description: "some description", name: "some name"}
  @update_attrs %{color: "some updated color", description: "some updated description", name: "some updated name"}
  @invalid_attrs %{color: nil, description: nil, name: nil}

  describe "index" do
    test "lists all venues", %{conn: conn} do
      conn = get(conn, ~p"/venues")
      assert html_response(conn, 200) =~ "Listing Venues"
    end
  end

  describe "new venue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/venues/new")
      assert html_response(conn, 200) =~ "New Venue"
    end
  end

  describe "create venue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/venues", venue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/venues/#{id}"

      conn = get(conn, ~p"/venues/#{id}")
      assert html_response(conn, 200) =~ "Venue #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/venues", venue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Venue"
    end
  end

  describe "edit venue" do
    setup [:create_venue]

    test "renders form for editing chosen venue", %{conn: conn, venue: venue} do
      conn = get(conn, ~p"/venues/#{venue}/edit")
      assert html_response(conn, 200) =~ "Edit Venue"
    end
  end

  describe "update venue" do
    setup [:create_venue]

    test "redirects when data is valid", %{conn: conn, venue: venue} do
      conn = put(conn, ~p"/venues/#{venue}", venue: @update_attrs)
      assert redirected_to(conn) == ~p"/venues/#{venue}"

      conn = get(conn, ~p"/venues/#{venue}")
      assert html_response(conn, 200) =~ "some updated color"
    end

    test "renders errors when data is invalid", %{conn: conn, venue: venue} do
      conn = put(conn, ~p"/venues/#{venue}", venue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Venue"
    end
  end

  describe "delete venue" do
    setup [:create_venue]

    test "deletes chosen venue", %{conn: conn, venue: venue} do
      conn = delete(conn, ~p"/venues/#{venue}")
      assert redirected_to(conn) == ~p"/venues"

      assert_error_sent 404, fn ->
        get(conn, ~p"/venues/#{venue}")
      end
    end
  end

  defp create_venue(_) do
    venue = venue_fixture()
    %{venue: venue}
  end
end
