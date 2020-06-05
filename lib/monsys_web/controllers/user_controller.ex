defmodule MonsysWeb.UserController do
  use MonsysWeb, :controller

  alias Monsys.Accounts
  alias Monsys.Accounts.User
  alias Monsys.Guardian

  require Logger

  action_fallback MonsysWeb.FallbackController

  def index(conn, _params) do
    user = Accounts.list_user()
    render(conn, "index.json", user: user)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    Logger.debug("show info #{inspect user}")
    # user = Accounts.get_user!(id)
    render(conn, "user.json", user: user)
  end

  def update_user(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    user_params = Map.put(user_params, "isAdmin", false)

    case Accounts.update_user_profile(user, user_params) do
      {:ok, %User{} = user}
        -> render(conn, "user.json", user: user)

      _ ->
        {:error, :unauthorized}
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user_profile(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
