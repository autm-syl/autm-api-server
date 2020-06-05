defmodule MonsysWeb.UploadsControllerTest do
  use MonsysWeb.ConnCase

  alias Monsys.Upload
  alias Monsys.Upload.Uploads

  @create_attrs %{
    file: "some file",
    name: "some name"
  }
  @update_attrs %{
    file: "some updated file",
    name: "some updated name"
  }
  @invalid_attrs %{file: nil, name: nil}

  def fixture(:uploads) do
    {:ok, uploads} = Upload.create_uploads(@create_attrs)
    uploads
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all upload", %{conn: conn} do
      conn = get(conn, Routes.uploads_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create uploads" do
    test "renders uploads when data is valid", %{conn: conn} do
      conn = post(conn, Routes.uploads_path(conn, :create), uploads: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.uploads_path(conn, :show, id))

      assert %{
               "id" => id,
               "file" => "some file",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.uploads_path(conn, :create), uploads: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update uploads" do
    setup [:create_uploads]

    test "renders uploads when data is valid", %{conn: conn, uploads: %Uploads{id: id} = uploads} do
      conn = put(conn, Routes.uploads_path(conn, :update, uploads), uploads: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.uploads_path(conn, :show, id))

      assert %{
               "id" => id,
               "file" => "some updated file",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, uploads: uploads} do
      conn = put(conn, Routes.uploads_path(conn, :update, uploads), uploads: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete uploads" do
    setup [:create_uploads]

    test "deletes chosen uploads", %{conn: conn, uploads: uploads} do
      conn = delete(conn, Routes.uploads_path(conn, :delete, uploads))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.uploads_path(conn, :show, uploads))
      end
    end
  end

  defp create_uploads(_) do
    uploads = fixture(:uploads)
    {:ok, uploads: uploads}
  end
end
