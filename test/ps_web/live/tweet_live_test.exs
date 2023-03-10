defmodule PsWeb.TweetLiveTest do
  use PsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ps.TweetsFixtures

  @create_attrs %{content: "some content", hashtags: "some hashtags"}
  @update_attrs %{content: "some updated content", hashtags: "some updated hashtags"}
  @invalid_attrs %{content: nil, hashtags: nil}

  defp create_tweet(_) do
    tweet = tweet_fixture()
    %{tweet: tweet}
  end

  describe "Index" do
    setup [:create_tweet]

    test "lists all tweets", %{conn: conn, tweet: tweet} do
      {:ok, _index_live, html} = live(conn, ~p"/tweets")

      assert html =~ "Listing Tweets"
      assert html =~ tweet.content
    end

    test "saves new tweet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tweets")

      assert index_live |> element("a", "New Tweet") |> render_click() =~
               "New Tweet"

      assert_patch(index_live, ~p"/tweets/new")

      assert index_live
             |> form("#tweet-form", tweet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tweet-form", tweet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tweets")

      assert html =~ "Tweet created successfully"
      assert html =~ "some content"
    end

    test "updates tweet in listing", %{conn: conn, tweet: tweet} do
      {:ok, index_live, _html} = live(conn, ~p"/tweets")

      assert index_live |> element("#tweets-#{tweet.id} a", "Edit") |> render_click() =~
               "Edit Tweet"

      assert_patch(index_live, ~p"/tweets/#{tweet}/edit")

      assert index_live
             |> form("#tweet-form", tweet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tweet-form", tweet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tweets")

      assert html =~ "Tweet updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes tweet in listing", %{conn: conn, tweet: tweet} do
      {:ok, index_live, _html} = live(conn, ~p"/tweets")

      assert index_live |> element("#tweets-#{tweet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tweet-#{tweet.id}")
    end
  end

  describe "Show" do
    setup [:create_tweet]

    test "displays tweet", %{conn: conn, tweet: tweet} do
      {:ok, _show_live, html} = live(conn, ~p"/tweets/#{tweet}")

      assert html =~ "Show Tweet"
      assert html =~ tweet.content
    end

    test "updates tweet within modal", %{conn: conn, tweet: tweet} do
      {:ok, show_live, _html} = live(conn, ~p"/tweets/#{tweet}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tweet"

      assert_patch(show_live, ~p"/tweets/#{tweet}/show/edit")

      assert show_live
             |> form("#tweet-form", tweet: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#tweet-form", tweet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tweets/#{tweet}")

      assert html =~ "Tweet updated successfully"
      assert html =~ "some updated content"
    end
  end
end
