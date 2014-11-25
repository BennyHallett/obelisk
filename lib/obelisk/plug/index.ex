defmodule Obelisk.Plug.Index do
   @moduledoc """
   A plug to serve a built `index.html` from the build directory
   on requests to the server's root (`/`).
   """

   @behaviour Plug
   
   @doc """
   Callback function for `Plug.init/1`.
   """
   def init(opts), do: opts

   @doc """
   Callback function for `Plug.call/2`.
   """
   def call(%Plug.Conn{path_info: [], state: state} = conn, _opts) when state in [:unset, :set] do
     path = Path.expand("./build/index.html")
     if File.exists? path do
       conn
         |> Plug.Conn.send_file(200, path)
         |> Plug.Conn.halt
     else
       conn
     end
   end
   def call(conn, _opts), do: conn
 end
