defmodule MonsysWeb.UploadsView do
  use MonsysWeb, :view
  alias MonsysWeb.UploadsView

  def render("index.json", %{upload: upload}) do
    %{data: render_many(upload, UploadsView, "uploads.json")}
  end

  def render("show.json", %{uploads: uploads}) do
    %{data: render_one(uploads, UploadsView, "uploads.json")}
  end

  def render("uploads.json", %{uploads: uploads}) do
    %{id: uploads.id,
      name: uploads.name,
      file: ""}
  end
end
