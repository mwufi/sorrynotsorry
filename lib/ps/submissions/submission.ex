defmodule Ps.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :body, :string
    field :link, :string
    field :name, :string

    belongs_to :author, Ps.Profiles.Profile
    many_to_many :comments, Ps.Comments.Comment, join_through: "submission_comments"

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:name, :body, :link])
    |> validate_required([:name, :body, :link])
  end
end
