defmodule Monsys.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string
      add :name, :string
      add :password_hash, :string
      add :avatar, :string
      add :role, :string
      add :status, :string
      add :isAdmin, :boolean, default: false, null: false
      add :ext, :string

      timestamps()
    end

    create unique_index(:user, [:email])
  end
end
