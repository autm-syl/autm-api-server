defmodule Monsys.Products.Skinstype do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skinstype" do
    field :ext, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(skinstype, attrs) do
    skinstype
    |> cast(attrs, [:name, :ext])
    |> validate_required([:name])
  end
end
