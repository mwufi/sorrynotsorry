defmodule Ps.Repo.Migrations.CreateProfileHeaderImg do
  use Ecto.Migration

  def change do
    alter table :profiles do
      add :header_img_url, :string
    end
  end
end
