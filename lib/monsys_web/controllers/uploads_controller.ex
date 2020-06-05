defmodule MonsysWeb.UploadsController do
  use MonsysWeb, :controller

  alias Monsys.Upload
  alias Monsys.Upload.Uploads
  alias Monsys.Guardian
  # alias Monsys.Accounts.User

  action_fallback MonsysWeb.FallbackController
  require Logger
  # def index(conn, %{"id" => id}) do
  #   Logger.debug("show _params _params: #{inspect id}")
  #   upload = Upload.list_upload()
  #   render(conn, "index.json", upload: upload)
  # end

  def create(conn, %{"uploads" => uploads_params}) do
    user = Guardian.Plug.current_resource(conn)
    case Guardian.Plug.current_resource(conn) do
      user
        ->
           with {:ok, %Uploads{} = uploads} <- Upload.create_uploads(uploads_params) do
            conn
            |> render("show.json", uploads: uploads)
          end

      nil ->
        {:error, :unauthorized}
    end
    # with {:ok, %Uploads{} = uploads} <- Upload.create_uploads(uploads_params) do
    #   conn
    #   |> render("show.json", uploads: uploads)
    # end
  end

  def show(conn, %{"id" => id}) do
    # user = Guardian.Plug.current_resource(conn)
    # case Upload.get_uploads!(id) do
    #   uploads
    #     ->
          uploads = Upload.get_uploads!(id)
          Logger.debug("show info xxxxxxxxxx #{inspect uploads.file}")

          file_all = String.split(uploads.file, ",")
          img = Base.decode64!(Enum.at(file_all, -1))
          conn
          |> put_resp_content_type("image/png")
          |> put_resp_header("content-disposition", "attachment; filename=#{uploads.name}")
          |> send_resp(200, img)
      # nil ->
      #   {:error, :unauthorized}
      # end
  end

  # def update(conn, %{"id" => id, "uploads" => uploads_params}) do
  #   uploads = Upload.get_uploads!(id)

  #   with {:ok, %Uploads{} = uploads} <- Upload.update_uploads(uploads, uploads_params) do
  #     render(conn, "show.json", uploads: uploads)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   uploads = Upload.get_uploads!(id)

  #   with {:ok, %Uploads{}} <- Upload.delete_uploads(uploads) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
