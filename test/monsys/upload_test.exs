defmodule Monsys.UploadTest do
  use Monsys.DataCase

  alias Monsys.Upload

  describe "upload" do
    alias Monsys.Upload.Uploads

    @valid_attrs %{file: "some file", name: "some name"}
    @update_attrs %{file: "some updated file", name: "some updated name"}
    @invalid_attrs %{file: nil, name: nil}

    def uploads_fixture(attrs \\ %{}) do
      {:ok, uploads} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Upload.create_uploads()

      uploads
    end

    test "list_upload/0 returns all upload" do
      uploads = uploads_fixture()
      assert Upload.list_upload() == [uploads]
    end

    test "get_uploads!/1 returns the uploads with given id" do
      uploads = uploads_fixture()
      assert Upload.get_uploads!(uploads.id) == uploads
    end

    test "create_uploads/1 with valid data creates a uploads" do
      assert {:ok, %Uploads{} = uploads} = Upload.create_uploads(@valid_attrs)
      assert uploads.file == "some file"
      assert uploads.name == "some name"
    end

    test "create_uploads/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Upload.create_uploads(@invalid_attrs)
    end

    test "update_uploads/2 with valid data updates the uploads" do
      uploads = uploads_fixture()
      assert {:ok, %Uploads{} = uploads} = Upload.update_uploads(uploads, @update_attrs)
      assert uploads.file == "some updated file"
      assert uploads.name == "some updated name"
    end

    test "update_uploads/2 with invalid data returns error changeset" do
      uploads = uploads_fixture()
      assert {:error, %Ecto.Changeset{}} = Upload.update_uploads(uploads, @invalid_attrs)
      assert uploads == Upload.get_uploads!(uploads.id)
    end

    test "delete_uploads/1 deletes the uploads" do
      uploads = uploads_fixture()
      assert {:ok, %Uploads{}} = Upload.delete_uploads(uploads)
      assert_raise Ecto.NoResultsError, fn -> Upload.get_uploads!(uploads.id) end
    end

    test "change_uploads/1 returns a uploads changeset" do
      uploads = uploads_fixture()
      assert %Ecto.Changeset{} = Upload.change_uploads(uploads)
    end
  end
end
