defmodule Monsys.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :monsys,
  module: Monsys.Guardian,
  error_handler: Monsys.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
