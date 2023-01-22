defmodule Ps.Logs.Visitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visitors" do
    field :cookie, :string
    field :first_visit, :utc_datetime
    field :last_visit, :utc_datetime
    field :name, :string
    field :status, :string
    field :visit_count, :integer

    timestamps()
  end

  @doc false
  def changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:name, :cookie, :last_visit, :first_visit, :status])
    |> validate_required([:name])
  end
end
