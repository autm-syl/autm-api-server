defmodule MonsysWeb.ItemControllerTest do
  use MonsysWeb.ConnCase

  alias Monsys.Products
  alias Monsys.Products.Item

  @create_attrs %{
    barcode: "some barcode",
    category_id: "some category_id",
    category_name: "some category_name",
    description: "some description",
    ext: "some ext",
    ingredient: "some ingredient",
    name: "some name",
    sku: "some sku",
    uses: "some uses"
  }
  @update_attrs %{
    barcode: "some updated barcode",
    category_id: "some updated category_id",
    category_name: "some updated category_name",
    description: "some updated description",
    ext: "some updated ext",
    ingredient: "some updated ingredient",
    name: "some updated name",
    sku: "some updated sku",
    uses: "some updated uses"
  }
  @invalid_attrs %{barcode: nil, category_id: nil, category_name: nil, description: nil, ext: nil, ingredient: nil, name: nil, sku: nil, uses: nil}

  def fixture(:item) do
    {:ok, item} = Products.create_item(@create_attrs)
    item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "barcode" => "some barcode",
               "category_id" => "some category_id",
               "category_name" => "some category_name",
               "description" => "some description",
               "ext" => "some ext",
               "ingredient" => "some ingredient",
               "name" => "some name",
               "sku" => "some sku",
               "uses" => "some uses"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "barcode" => "some updated barcode",
               "category_id" => "some updated category_id",
               "category_name" => "some updated category_name",
               "description" => "some updated description",
               "ext" => "some updated ext",
               "ingredient" => "some updated ingredient",
               "name" => "some updated name",
               "sku" => "some updated sku",
               "uses" => "some updated uses"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.item_path(conn, :delete, item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    {:ok, item: item}
  end
end
