defmodule Monsys.Repo.Migrations.CreateSkinstype do
  use Ecto.Migration

  def change do
    create table(:skinstype) do
      add :name, :string
      add :ext, :string

      timestamps()
    end

    create unique_index(:skinstype, [:name])
  end
end
