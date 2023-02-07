defmodule Ps.ProfilesTest do
  use Ps.DataCase

  alias Ps.Profiles

  describe "profiles" do
    alias Ps.Profiles.Profile

    import Ps.ProfilesFixtures

    @invalid_attrs %{avatar_url: nil, bio: nil, name: nil, username: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Profiles.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Profiles.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{
        avatar_url: "some avatar_url",
        bio: "some bio",
        name: "some name",
        username: "some username"
      }

      assert {:ok, %Profile{} = profile} = Profiles.create_profile(valid_attrs)
      assert profile.avatar_url == "some avatar_url"
      assert profile.bio == "some bio"
      assert profile.name == "some name"
      assert profile.username == "some username"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()

      update_attrs = %{
        avatar_url: "some updated avatar_url",
        bio: "some updated bio",
        name: "some updated name",
        username: "some updated username"
      }

      assert {:ok, %Profile{} = profile} = Profiles.update_profile(profile, update_attrs)
      assert profile.avatar_url == "some updated avatar_url"
      assert profile.bio == "some updated bio"
      assert profile.name == "some updated name"
      assert profile.username == "some updated username"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_profile(profile, @invalid_attrs)
      assert profile == Profiles.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Profiles.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Profiles.change_profile(profile)
    end
  end
end
