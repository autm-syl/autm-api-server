defmodule Monsys.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :cate_id, :string
      add :ext, :string

      timestamps()
    end

    create unique_index(:categories, [:name])

  end
end
