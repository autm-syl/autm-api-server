defmodule MonsysWeb.SkinstypeControllerTest do
  use MonsysWeb.ConnCase

  alias Monsys.Products
  alias Monsys.Products.Skinstype

  @create_attrs %{
    ext: "some ext",
    name: "some name"
  }
  @update_attrs %{
    ext: "some updated ext",
    name: "some updated name"
  }
  @invalid_attrs %{ext: nil, name: nil}

  def fixture(:skinstype) do
    {:ok, skinstype} = Products.create_skinstype(@create_attrs)
    skinstype
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all skinstype", %{conn: conn} do
      conn = get(conn, Routes.skinstype_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create skinstype" do
    test "renders skinstype when data is valid", %{conn: conn} do
      conn = post(conn, Routes.skinstype_path(conn, :create), skinstype: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.skinstype_path(conn, :show, id))

      assert %{
               "id" => id,
               "ext" => "some ext",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.skinstype_path(conn, :create), skinstype: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update skinstype" do
    setup [:create_skinstype]

    test "renders skinstype when data is valid", %{conn: conn, skinstype: %Skinstype{id: id} = skinstype} do
      conn = put(conn, Routes.skinstype_path(conn, :update, skinstype), skinstype: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.skinstype_path(conn, :show, id))

      assert %{
               "id" => id,
               "ext" => "some updated ext",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, skinstype: skinstype} do
      conn = put(conn, Routes.skinstype_path(conn, :update, skinstype), skinstype: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete skinstype" do
    setup [:create_skinstype]

    test "deletes chosen skinstype", %{conn: conn, skinstype: skinstype} do
      conn = delete(conn, Routes.skinstype_path(conn, :delete, skinstype))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.skinstype_path(conn, :show, skinstype))
      end
    end
  end

  defp create_skinstype(_) do
    skinstype = fixture(:skinstype)
    {:ok, skinstype: skinstype}
  end
end
