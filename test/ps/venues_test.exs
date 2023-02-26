defmodule Ps.VenuesTest do
  use Ps.DataCase

  alias Ps.Venues

  describe "venues" do
    alias Ps.Venues.Venue

    import Ps.VenuesFixtures

    @invalid_attrs %{color: nil, description: nil, name: nil}

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Venues.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Venues.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      valid_attrs = %{color: "some color", description: "some description", name: "some name"}

      assert {:ok, %Venue{} = venue} = Venues.create_venue(valid_attrs)
      assert venue.color == "some color"
      assert venue.description == "some description"
      assert venue.name == "some name"
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()
      update_attrs = %{color: "some updated color", description: "some updated description", name: "some updated name"}

      assert {:ok, %Venue{} = venue} = Venues.update_venue(venue, update_attrs)
      assert venue.color == "some updated color"
      assert venue.description == "some updated description"
      assert venue.name == "some updated name"
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_venue(venue, @invalid_attrs)
      assert venue == Venues.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Venues.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Venues.change_venue(venue)
    end
  end
end
