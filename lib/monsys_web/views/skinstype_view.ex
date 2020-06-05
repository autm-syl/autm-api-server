defmodule MonsysWeb.SkinstypeView do
  use MonsysWeb, :view
  alias MonsysWeb.SkinstypeView

  def render("index.json", %{skinstype: skinstype}) do
    %{data: render_many(skinstype, SkinstypeView, "skinstype.json")}
  end

  def render("show.json", %{skinstype: skinstype}) do
    %{data: render_one(skinstype, SkinstypeView, "skinstype.json")}
  end

  def render("skinstype.json", %{skinstype: skinstype}) do
    %{id: skinstype.id,
      name: skinstype.name,
      ext: skinstype.ext}
  end
end
