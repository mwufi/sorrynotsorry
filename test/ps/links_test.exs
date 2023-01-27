defmodule Ps.LinksTest do
  use Ps.DataCase

  alias Ps.Links

  describe "links" do
    alias Ps.Links.Link

    import Ps.LinksFixtures

    @invalid_attrs %{click_count: nil, href: nil, name: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{click_count: 42, href: "some href", name: "some name"}

      assert {:ok, %Link{} = link} = Links.create_link(valid_attrs)
      assert link.click_count == 42
      assert link.href == "some href"
      assert link.name == "some name"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{click_count: 43, href: "some updated href", name: "some updated name"}

      assert {:ok, %Link{} = link} = Links.update_link(link, update_attrs)
      assert link.click_count == 43
      assert link.href == "some updated href"
      assert link.name == "some updated name"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
