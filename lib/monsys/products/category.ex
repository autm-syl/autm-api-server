defmodule Monsys.Products.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :cate_id, :string
    field :ext, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :cate_id, :ext])
    |> validate_required([:name, :ext])
  end
end
