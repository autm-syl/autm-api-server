defmodule Monsys.ProductsTest do
  use Monsys.DataCase

  alias Monsys.Products

  describe "items" do
    alias Monsys.Products.Item

    @valid_attrs %{barcode: "some barcode", category_id: "some category_id", category_name: "some category_name", description: "some description", ext: "some ext", ingredient: "some ingredient", name: "some name", sku: "some sku", uses: "some uses"}
    @update_attrs %{barcode: "some updated barcode", category_id: "some updated category_id", category_name: "some updated category_name", description: "some updated description", ext: "some updated ext", ingredient: "some updated ingredient", name: "some updated name", sku: "some updated sku", uses: "some updated uses"}
    @invalid_attrs %{barcode: nil, category_id: nil, category_name: nil, description: nil, ext: nil, ingredient: nil, name: nil, sku: nil, uses: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Products.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Products.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Products.create_item(@valid_attrs)
      assert item.barcode == "some barcode"
      assert item.category_id == "some category_id"
      assert item.category_name == "some category_name"
      assert item.description == "some description"
      assert item.ext == "some ext"
      assert item.ingredient == "some ingredient"
      assert item.name == "some name"
      assert item.sku == "some sku"
      assert item.uses == "some uses"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Products.update_item(item, @update_attrs)
      assert item.barcode == "some updated barcode"
      assert item.category_id == "some updated category_id"
      assert item.category_name == "some updated category_name"
      assert item.description == "some updated description"
      assert item.ext == "some updated ext"
      assert item.ingredient == "some updated ingredient"
      assert item.name == "some updated name"
      assert item.sku == "some updated sku"
      assert item.uses == "some updated uses"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_item(item, @invalid_attrs)
      assert item == Products.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Products.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Products.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Products.change_item(item)
    end
  end

  describe "categories" do
    alias Monsys.Products.Category

    @valid_attrs %{cate_id: "some cate_id", ext: "some ext", name: "some name"}
    @update_attrs %{cate_id: "some updated cate_id", ext: "some updated ext", name: "some updated name"}
    @invalid_attrs %{cate_id: nil, ext: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Products.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Products.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Products.create_category(@valid_attrs)
      assert category.cate_id == "some cate_id"
      assert category.ext == "some ext"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Products.update_category(category, @update_attrs)
      assert category.cate_id == "some updated cate_id"
      assert category.ext == "some updated ext"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_category(category, @invalid_attrs)
      assert category == Products.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Products.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Products.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Products.change_category(category)
    end
  end

  describe "skinstype" do
    alias Monsys.Products.Skinstype

    @valid_attrs %{ext: "some ext", name: "some name"}
    @update_attrs %{ext: "some updated ext", name: "some updated name"}
    @invalid_attrs %{ext: nil, name: nil}

    def skinstype_fixture(attrs \\ %{}) do
      {:ok, skinstype} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_skinstype()

      skinstype
    end

    test "list_skinstype/0 returns all skinstype" do
      skinstype = skinstype_fixture()
      assert Products.list_skinstype() == [skinstype]
    end

    test "get_skinstype!/1 returns the skinstype with given id" do
      skinstype = skinstype_fixture()
      assert Products.get_skinstype!(skinstype.id) == skinstype
    end

    test "create_skinstype/1 with valid data creates a skinstype" do
      assert {:ok, %Skinstype{} = skinstype} = Products.create_skinstype(@valid_attrs)
      assert skinstype.ext == "some ext"
      assert skinstype.name == "some name"
    end

    test "create_skinstype/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_skinstype(@invalid_attrs)
    end

    test "update_skinstype/2 with valid data updates the skinstype" do
      skinstype = skinstype_fixture()
      assert {:ok, %Skinstype{} = skinstype} = Products.update_skinstype(skinstype, @update_attrs)
      assert skinstype.ext == "some updated ext"
      assert skinstype.name == "some updated name"
    end

    test "update_skinstype/2 with invalid data returns error changeset" do
      skinstype = skinstype_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_skinstype(skinstype, @invalid_attrs)
      assert skinstype == Products.get_skinstype!(skinstype.id)
    end

    test "delete_skinstype/1 deletes the skinstype" do
      skinstype = skinstype_fixture()
      assert {:ok, %Skinstype{}} = Products.delete_skinstype(skinstype)
      assert_raise Ecto.NoResultsError, fn -> Products.get_skinstype!(skinstype.id) end
    end

    test "change_skinstype/1 returns a skinstype changeset" do
      skinstype = skinstype_fixture()
      assert %Ecto.Changeset{} = Products.change_skinstype(skinstype)
    end
  end
end
