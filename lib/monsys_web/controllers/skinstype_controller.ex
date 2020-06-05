defmodule MonsysWeb.SkinstypeController do
  use MonsysWeb, :controller

  alias Monsys.Products
  alias Monsys.Products.Skinstype

  action_fallback MonsysWeb.FallbackController

  def index(conn, _params) do
    skinstype = Products.list_skinstype()
    render(conn, "index.json", skinstype: skinstype)
  end

  def create(conn, %{"skinstype" => skinstype_params}) do
    with {:ok, %Skinstype{} = skinstype} <- Products.create_skinstype(skinstype_params) do
      conn
      |> render("show.json", skinstype: skinstype)
    end
  end

  def show(conn, %{"id" => id}) do
    skinstype = Products.get_skinstype!(id)
    render(conn, "show.json", skinstype: skinstype)
  end

  def update(conn, %{"id" => id, "skinstype" => skinstype_params}) do
    skinstype = Products.get_skinstype!(id)

    with {:ok, %Skinstype{} = skinstype} <- Products.update_skinstype(skinstype, skinstype_params) do
      render(conn, "show.json", skinstype: skinstype)
    end
  end

  def delete(conn, %{"id" => id}) do
    skinstype = Products.get_skinstype!(id)

    with {:ok, %Skinstype{}} <- Products.delete_skinstype(skinstype) do
      send_resp(conn, :no_content, "")
    end
  end
end
