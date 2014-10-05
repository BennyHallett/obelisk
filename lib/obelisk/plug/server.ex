defmodule Obelisk.Plug.Server do
  use Plug.Builder

  plug Plug.Static, at: "/", from: "./build/"
  plug :not_found

  def not_found(conn, _) do
    Plug.Conn.send(conn, 404, "not found")
  end
end
