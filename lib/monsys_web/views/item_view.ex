defmodule MonsysWeb.ItemView do
  use MonsysWeb, :view
  alias MonsysWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("error.json", %{changeset: changeset}) do
    %{data: render_one(changeset, ItemView, "changeset.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      name: item.name,
      description: item.description,
      barcode: item.barcode,
      sku: item.sku,
      uses: item.uses,
      ingredient: item.ingredient,
      category_name: item.category_name,
      skinstype_name: item.skinstype_name,
      category_id: item.category_id,
      ext: item.ext,
      cost: item.cost,
      previews: item.previews}
  end

  def render("changeset.json", %{changeset: changeset}) do
    %{error: changeset.errors}
  end
end
