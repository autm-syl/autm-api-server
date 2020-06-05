defmodule Monsys.Upload.Uploads do
  use Ecto.Schema
  import Ecto.Changeset

  schema "upload" do
    field :file, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(uploads, attrs) do
    uploads
    |> cast(attrs, [:name, :file])
    |> validate_required([:name, :file])
  end
end
