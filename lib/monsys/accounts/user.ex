defmodule Monsys.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "user" do
    field :avatar, :string, default: ""
    field :email, :string
    field :ext, :string, default: ""
    field :isAdmin, :boolean, default: false
    field :name, :string, default: "none"
    field :password_hash, :string
    field :role, :string, default: "member"
    field :status, :string, default: "off"

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 4) # Check that password length is >= 4
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> put_password_hash
  end

  def changeset_update_profile(user, attrs) do
    user
    |> cast(attrs, [:email, :avatar, :ext, :name, :role, :status]) # Remove hash
    |> validate_required([:email]) # Remove hash, add pw + pw confirmation
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> unique_constraint(:email)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
