defmodule PsWeb.ProfileLiveTest do
  use PsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ps.ProfilesFixtures

  @create_attrs %{avatar_url: "some avatar_url", bio: "some bio", name: "some name", username: "some username"}
  @update_attrs %{avatar_url: "some updated avatar_url", bio: "some updated bio", name: "some updated name", username: "some updated username"}
  @invalid_attrs %{avatar_url: nil, bio: nil, name: nil, username: nil}

  defp create_profile(_) do
    profile = profile_fixture()
    %{profile: profile}
  end

  describe "Index" do
    setup [:create_profile]

    test "lists all profiles", %{conn: conn, profile: profile} do
      {:ok, _index_live, html} = live(conn, ~p"/profiles")

      assert html =~ "Listing Profiles"
      assert html =~ profile.avatar_url
    end

    test "saves new profile", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/profiles")

      assert index_live |> element("a", "New Profile") |> render_click() =~
               "New Profile"

      assert_patch(index_live, ~p"/profiles/new")

      assert index_live
             |> form("#profile-form", profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#profile-form", profile: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/profiles")

      assert html =~ "Profile created successfully"
      assert html =~ "some avatar_url"
    end

    test "updates profile in listing", %{conn: conn, profile: profile} do
      {:ok, index_live, _html} = live(conn, ~p"/profiles")

      assert index_live |> element("#profiles-#{profile.id} a", "Edit") |> render_click() =~
               "Edit Profile"

      assert_patch(index_live, ~p"/profiles/#{profile}/edit")

      assert index_live
             |> form("#profile-form", profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#profile-form", profile: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/profiles")

      assert html =~ "Profile updated successfully"
      assert html =~ "some updated avatar_url"
    end

    test "deletes profile in listing", %{conn: conn, profile: profile} do
      {:ok, index_live, _html} = live(conn, ~p"/profiles")

      assert index_live |> element("#profiles-#{profile.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#profile-#{profile.id}")
    end
  end

  describe "Show" do
    setup [:create_profile]

    test "displays profile", %{conn: conn, profile: profile} do
      {:ok, _show_live, html} = live(conn, ~p"/profiles/#{profile}")

      assert html =~ "Show Profile"
      assert html =~ profile.avatar_url
    end

    test "updates profile within modal", %{conn: conn, profile: profile} do
      {:ok, show_live, _html} = live(conn, ~p"/profiles/#{profile}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Profile"

      assert_patch(show_live, ~p"/profiles/#{profile}/show/edit")

      assert show_live
             |> form("#profile-form", profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#profile-form", profile: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/profiles/#{profile}")

      assert html =~ "Profile updated successfully"
      assert html =~ "some updated avatar_url"
    end
  end
end
