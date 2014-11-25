defmodule Obelisk.Plug.Server do
  @moduledoc """
  A plug for serving Obelisk-generated content.
  """
  use Plug.Builder

  plug Plug.Static, at: "/", from: "./build/"
  plug Obelisk.Plug.Index
  plug :not_found

  @doc """
  Sends all unknown requests a 404.
  """
  def not_found(conn, _) do
    Plug.Conn.send_resp(conn, 404, "Resource not found. If you're looking for the index page, try http://localhost:4000/")
  end
end
