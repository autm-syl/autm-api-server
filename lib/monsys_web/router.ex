defmodule MonsysWeb.Router do
  use MonsysWeb, :router

  alias Monsys.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", MonsysWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    get "/image", UploadsController, :show
  end

  scope "/api/v1", MonsysWeb do
    pipe_through :api
    pipe_through :jwt_authenticated

    get "/my_user", UserController, :show
    post "/user_update", UserController, :update_user
    get "/category", CategoryController, :index
    post "/category", CategoryController, :create
    put "/category", CategoryController, :update

    get "/skinstype", SkinstypeController, :index
    post "/skinstype", SkinstypeController, :create
    put "/skinstype", SkinstypeController, :update

    get "/all_product", ItemController, :index
    get "/product", ItemController, :show
    post "/product", ItemController, :create
    put "/product", ItemController, :update
    delete "/product", ItemController, :delete

    post "/upload", UploadsController, :create

  end

end
