defmodule Ps.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :body, :string
    field :link, :string
    field :name, :string
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:name, :body, :link])
    |> validate_required([:name, :body, :link])
  end
end
