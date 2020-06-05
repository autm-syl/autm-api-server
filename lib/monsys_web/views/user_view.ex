defmodule MonsysWeb.UserView do
  use MonsysWeb, :view
  alias MonsysWeb.UserView

  def render("index.json", %{user: user}) do
    %{data: render_many(user, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      password_hash: user.password_hash,
      avatar: user.avatar,
      role: user.role,
      status: user.status,
      isAdmin: user.isAdmin,
      ext: user.ext}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

end
