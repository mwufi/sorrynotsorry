defmodule Ps.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  use LetMe.Schema
  import Ecto.Query

  schema "posts" do
    field(:content, :string)
    field(:is_draft, :boolean, default: true)
    field(:subtitle, :string)
    field(:title, :string)
    field(:permalink, :string)

    belongs_to(:author, Ps.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :title, :subtitle, :is_draft, :author_id, :permalink])
    |> validate_required([:content, :title, :subtitle, :is_draft, :author_id])
    |> validate_permalink()
    |> IO.inspect(label: "at the end of changeset")
  end

  defp validate_permalink(changeset) do
    case get_change(changeset, :permalink) do
      nil ->
        changeset

      permalink ->
        IO.inspect(permalink, label: "ddd")

        changeset
        |> put_change(:permalink, URI.encode(permalink))
    end
  end

  @impl LetMe.Schema
  def scope(q, user, _opts \\ nil) do
    from(p in q, where: p.author_id == ^user.id)
  end
end
