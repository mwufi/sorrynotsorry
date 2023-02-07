defmodule Ps.Policy.Checks do
  alias Ps.Accounts.User
  alias Ps.Profiles.Profile
  alias Ps.Posts.Post

  @doc """
  Checks whether the user ID of the object matches the ID of the current user.

  Assumes that the object has a `:user_id` field.

  For resources that are owned by Profiles, check the profile id instead.
  """
  def own_resource(user, post, _opts \\ nil)
  def own_resource(%User{id: id}, %Post{author_id: id}, _opts), do: true
  def own_resource(%User{id: id}, %{user_id: id}, _opts), do: true
  def own_resource(%Profile{id: id}, %{profile_id: id}, _opts), do: true

  def own_resource(_, _, _) do
    false
  end

  @doc """
    Checks whether the post is public.

    Assumes that the object has a `:is_draft` field.
  """
  def public_post(user, post, _opts \\ nil)

  def public_post(_, %Post{is_draft: false}, _) do
    IO.puts("public_post")
    true
  end

  def public_post(_, _, _) do
    IO.puts("public_post false")
    false
  end

  @doc """
  Checks whether the user role matches the role passed as an option.

  ## Usage

      allow role: :editor

  or

      allow {:role, :editor}
  """
  def role(_, _, _), do: false
end
