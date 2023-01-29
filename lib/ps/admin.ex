defmodule Ps.Admin do
  alias Ps.Repo
  alias Ps.Accounts.User
  alias Ps.Profiles.Profile
  alias Ps.Profiles

  import Ecto.Query

  @doc """
  Create a profile for each existing user
  """
  def create_profiles_for_existing_users do
    query =
      from(u in User,
        left_join: o in assoc(u, :primary_profile),
        where: is_nil(o.user_id)
      )

    query
    |> Repo.all()
    |> Enum.map(fn user ->
      IO.puts("Creating profile for user #{user.id} - #{user.email}")

      user
      |> Repo.preload(:primary_profile)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:primary_profile, %{
        user_id: user.id,
        name: "user#{user.id}",
        username: "user#{user.id}"
      })
      |> Repo.update()
    end)
  end

  def delete_null_profiles do
    query = from(p in Profile, where: is_nil(p.user_id)) |> Repo.delete_all()
  end

  def check_profiles do
    query =
      from(u in User,
        left_join: o in assoc(u, :primary_profile),
        where: is_nil(o.user_id)
      )

    query
    |> Repo.all()
    |> Enum.map(fn user ->
      IO.puts("User has no primary profile: #{user.id} - #{user.email}")
    end)
  end
end
