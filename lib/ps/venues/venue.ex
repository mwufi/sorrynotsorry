defmodule Ps.Venues.Venue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field :color, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(venue, attrs) do
    venue
    |> cast(attrs, [:name, :description, :color])
    |> validate_required([:name, :description, :color])
  end
end
