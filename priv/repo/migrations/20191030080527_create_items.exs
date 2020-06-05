defmodule Monsys.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :barcode, :string
      add :sku, :string
      add :uses, :string
      add :ingredient, :string
      add :category_name, :string
      add :skinstype_name, :string
      add :category_id, :string
      add :ext, :string
      add :cost, :string
      add :previews, {:array, :string}

      timestamps()
    end

    create unique_index(:items, [:barcode])

  end
end
