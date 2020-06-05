defmodule MonsysWeb.ItemController do
  use MonsysWeb, :controller

  alias Monsys.Products
  alias Monsys.Products.Item

  alias Monsys.Guardian
  alias Monsys.Accounts.User
  require Logger

  action_fallback MonsysWeb.FallbackController

  def index(conn, _params) do
    items = Products.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do

    case Products.create_item(item_params) do
      {:ok, %Item{} = item}
      ->
        Logger.debug("create_item dc roi: #{inspect item}")
        conn
        |> render("show.json", item: item)
      {:error, error}
      ->

        # msg = handle_error(error)
        Logger.debug("create_item loi con ba no: #{inspect error.errors}")
        conn
        |> put_status(:method_not_allowed)
        |> json(%{error: Kernel.inspect(error.errors)})
      _ ->
        Logger.debug("create_item loi con ba no deo biet: ")
        {:error, :existed}

    end

    # with {:ok, %Item{} = item} <- Products.create_item(item_params) do
    #   conn
    #   |> render("show.json", item: item)
    # end
  end

  def show(conn, %{"id" => id}) do
    item = Products.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Products.get_item!(id)

    with {:ok, %Item{} = item} <- Products.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    #  user = Guardian.Plug.current_resource(conn)
    case Guardian.Plug.current_resource(conn) do
      user
      ->
        if user.role == "admin" do
          item = Products.get_item!(id)
          with {:ok, %Item{}} <- Products.delete_item(item) do
            send_resp(conn, :no_content, "")
          end
        else
          {:error, :unauthorized}
        end

      nil
      ->
        {:error, :unauthorized}
    end
    # item = Products.get_item!(id)

    # with {:ok, %Item{}} <- Products.delete_item(item) do
    #   send_resp(conn, :no_content, "")
    # end
  end
end
