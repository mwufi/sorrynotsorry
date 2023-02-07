defmodule Ps.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Ps.Repo
  alias Ps.Policy

  alias Ps.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts_for_user(current_user) do
    Post |> Post.scope(current_user) |> Repo.all()
  end

  def list_public_posts(exclude_user \\ nil) do
    if exclude_user do
      Post |> where([p], p.author_id != ^exclude_user.id) |> where(is_draft: false) |> Repo.all()
    else
      Post |> where(is_draft: false) |> Repo.all()
    end
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Gets a single post.

  Returns `nil` if the Post does not exist.
  """
  def get_post_for_user(current_user, id) do
    post =
      Post
      |> where(id: ^id)
      |> Repo.one()

    with :ok <- Policy.authorize(:post_read, current_user, post) do
      {:ok, post}
    end
  end

  @doc """
  Find a public post by permalink.
  """
  def get_post_by_permalink(permalink) do
    Post |> where(permalink: ^permalink) |> where(is_draft: false) |> Repo.one()
  end

  def get_author_profile(%Post{} = post) do
    post |> Ecto.assoc([:author, :primary_profile]) |> Repo.one()
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post_for_user(%{field: value})
      {:ok, %Post{}}

      iex> create_post_for_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_for_user(current_user, attrs \\ %{}) do
    with :ok <- Policy.authorize(:post_create, current_user) do
      Ecto.build_assoc(current_user, :posts)
      |> Post.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def update_post_for_user(%Post{} = post, current_user, attrs) do
    with :ok <- Policy.authorize(:post_update, current_user, post) do
      post
      |> Post.changeset(attrs)
      |> IO.inspect(label: "update_post")
      |> Repo.update()
    end
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def delete_post_for_user(%Post{} = post, current_user) do
    with :ok <- Policy.authorize(:post_delete, current_user, post) do
      Repo.delete(post)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
