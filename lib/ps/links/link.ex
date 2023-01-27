defmodule Ps.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :click_count, :integer, default: 0
    field :href, :string
    field :name, :string
    belongs_to :profile, Ps.Profiles.Profile

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:name, :href])
    |> validate_required([:name, :href])
  end
end
