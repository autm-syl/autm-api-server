defmodule Monsys.Products.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :barcode, :string
    field :category_id, :string
    field :category_name, :string
    field :skinstype_name, :string
    field :description, :string
    field :ext, :string
    field :ingredient, :string
    field :name, :string
    field :sku, :string
    field :uses, :string
    field :cost, :string
    field :previews, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :barcode, :sku, :uses, :ingredient, :category_name,:skinstype_name, :category_id, :ext, :cost, :previews])
    |> validate_required([:category_id, :barcode])
    |> unique_constraint(:barcode)
  end
end
