defmodule Ps.LogsTest do
  use Ps.DataCase

  alias Ps.Logs

  describe "visitors" do
    alias Ps.Logs.Visitor

    import Ps.LogsFixtures

    @invalid_attrs %{cookie: nil, first_visit: nil, last_visit: nil, name: nil, status: nil, visit_count: nil}

    test "list_visitors/0 returns all visitors" do
      visitor = visitor_fixture()
      assert Logs.list_visitors() == [visitor]
    end

    test "get_visitor!/1 returns the visitor with given id" do
      visitor = visitor_fixture()
      assert Logs.get_visitor!(visitor.id) == visitor
    end

    test "create_visitor/1 with valid data creates a visitor" do
      valid_attrs = %{cookie: "some cookie", first_visit: ~U[2023-01-21 01:51:00Z], last_visit: ~U[2023-01-21 01:51:00Z], name: "some name", status: "some status", visit_count: 42}

      assert {:ok, %Visitor{} = visitor} = Logs.create_visitor(valid_attrs)
      assert visitor.cookie == "some cookie"
      assert visitor.first_visit == ~U[2023-01-21 01:51:00Z]
      assert visitor.last_visit == ~U[2023-01-21 01:51:00Z]
      assert visitor.name == "some name"
      assert visitor.status == "some status"
      assert visitor.visit_count == 42
    end

    test "create_visitor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logs.create_visitor(@invalid_attrs)
    end

    test "update_visitor/2 with valid data updates the visitor" do
      visitor = visitor_fixture()
      update_attrs = %{cookie: "some updated cookie", first_visit: ~U[2023-01-22 01:51:00Z], last_visit: ~U[2023-01-22 01:51:00Z], name: "some updated name", status: "some updated status", visit_count: 43}

      assert {:ok, %Visitor{} = visitor} = Logs.update_visitor(visitor, update_attrs)
      assert visitor.cookie == "some updated cookie"
      assert visitor.first_visit == ~U[2023-01-22 01:51:00Z]
      assert visitor.last_visit == ~U[2023-01-22 01:51:00Z]
      assert visitor.name == "some updated name"
      assert visitor.status == "some updated status"
      assert visitor.visit_count == 43
    end

    test "update_visitor/2 with invalid data returns error changeset" do
      visitor = visitor_fixture()
      assert {:error, %Ecto.Changeset{}} = Logs.update_visitor(visitor, @invalid_attrs)
      assert visitor == Logs.get_visitor!(visitor.id)
    end

    test "delete_visitor/1 deletes the visitor" do
      visitor = visitor_fixture()
      assert {:ok, %Visitor{}} = Logs.delete_visitor(visitor)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_visitor!(visitor.id) end
    end

    test "change_visitor/1 returns a visitor changeset" do
      visitor = visitor_fixture()
      assert %Ecto.Changeset{} = Logs.change_visitor(visitor)
    end
  end
end
