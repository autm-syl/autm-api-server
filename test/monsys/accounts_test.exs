defmodule Monsys.AccountsTest do
  use Monsys.DataCase

  alias Monsys.Accounts

  describe "user" do
    alias Monsys.Accounts.User

    @valid_attrs %{avatar: "some avatar", email: "some email", ext: "some ext", isAdmin: true, name: "some name", password_hash: "some password_hash", role: "some role", status: "some status"}
    @update_attrs %{avatar: "some updated avatar", email: "some updated email", ext: "some updated ext", isAdmin: false, name: "some updated name", password_hash: "some updated password_hash", role: "some updated role", status: "some updated status"}
    @invalid_attrs %{avatar: nil, email: nil, ext: nil, isAdmin: nil, name: nil, password_hash: nil, role: nil, status: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Accounts.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.ext == "some ext"
      assert user.isAdmin == true
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.role == "some role"
      assert user.status == "some status"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.ext == "some updated ext"
      assert user.isAdmin == false
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.role == "some updated role"
      assert user.status == "some updated status"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
