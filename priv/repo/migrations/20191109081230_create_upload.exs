defmodule Monsys.Repo.Migrations.CreateUpload do
  use Ecto.Migration

  def change do
    create table(:upload) do
      add :name, :string
      add :file, :text

      timestamps()
    end

  end
end
