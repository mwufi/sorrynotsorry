defmodule PsWeb.PostApiController do
  use PsWeb, :controller

  alias Ps.Posts

  def create(conn, %{"post" => post_params}) do
    current_user = conn.assigns.current_user

    case Posts.create_post_for_user(current_user, post_params) do
      {:ok, post} ->
        json(conn, %{success: "Post created successfully.", id: post.id, title: post.title})

      {:error, %Ecto.Changeset{} = _changeset} ->
        json(conn, %{error: "Post could not be created."})
    end
  end
end
