defmodule PsWeb.PostController do
  use PsWeb, :controller

  alias Ps.Posts
  alias Ps.Posts.Post

  def index(conn, _params) do
    if(conn.assigns.current_user == nil) do
      posts = Posts.list_public_posts()
      render(conn, :index, public_posts: posts, posts: [])
    else
      posts = Posts.list_posts_for_user(conn.assigns.current_user)

      render(conn, :index,
        public_posts: Posts.list_public_posts(conn.assigns.current_user),
        posts: posts
      )
    end
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    current_user = conn.assigns.current_user

    case Posts.create_post_for_user(current_user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show_permalink(conn, %{"permalink" => permalink}) do
    post = Posts.get_post_by_permalink(permalink)

    if post == nil do
      conn
      |> put_flash(:error, "Post not found.")
      |> redirect(to: "/posts")
    else
      can_edit =
        conn.assigns.current_user != nil and conn.assigns.current_user.id == post.author_id

      author_profile = Posts.get_author_profile(post)
      render(conn, :show, post: post, can_edit: can_edit, author_profile: author_profile)
    end
  end

  def show(conn, %{"id" => id}) do
    case Posts.get_post_for_user(conn.assigns.current_user, id) do
      {:ok, post} ->
        can_edit =
          conn.assigns.current_user != nil and conn.assigns.current_user.id == post.author_id

        author_profile = Posts.get_author_profile(post)
        render(conn, :show, post: post, can_edit: can_edit, author_profile: author_profile)

      {:error, :unauthorized} ->
        IO.puts("unauthorized!!!")

        conn
        |> put_flash(:error, "Post not found.")
        |> redirect(to: "/posts")
    end
  end

  def edit(conn, %{"id" => id}) do
    {:ok, post} = Posts.get_post_for_user(conn.assigns.current_user, id)

    changeset = Posts.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    {:ok, post} = Posts.get_post_for_user(conn.assigns.current_user, id)

    case Posts.update_post_for_user(post, conn.assigns.current_user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, post} = Posts.get_post_for_user(conn.assigns.current_user, id)
    {:ok, _post} = Posts.delete_post_for_user(post, conn.assigns.current_user)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end
end
