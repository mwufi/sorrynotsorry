defmodule Ps.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :author, Ps.Profiles.Profile
    belongs_to :submission, Ps.Submissions.Submission

    # optional (for replies only)
    belongs_to :parent, Ps.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> cast_assoc(:submission, required: true)
    |> cast_assoc(:author, required: true)
    |> validate_required([:body])
  end
end
