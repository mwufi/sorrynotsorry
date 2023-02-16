defmodule PsWeb.ProfileController do
  use PsWeb, :controller

  alias Ps.Profiles

  def show(conn, %{"username" => username}) do
    profile = Profiles.get_profile_by_username!(username)
    render(conn, "show.html", profile: profile)
  end

  def edit(conn, %{"username" => username}) do
    profile = Profiles.get_profile_by_username!(username)
    changeset = Profiles.change_profile(profile)
    render(conn, "edit.html", profile: profile, changeset: changeset)
  end

  def update(conn, %{"username" => username, "profile" => profile_params}) do
    profile = Profiles.get_profile_by_username!(username)

    case Profiles.update_profile_for_user(
           profile,
           conn.assigns.current_user,
           profile_params
         ) do
      {:ok, profile} ->
        conn
        |> put_flash(:info, "profile updated successfully.")
        |> redirect(to: ~p"/#{profile.username}")

      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "lol, you can't update this profile!")
        |> redirect(to: ~p"/#{profile.username}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, profile: profile, changeset: changeset)
    end
  end
end
