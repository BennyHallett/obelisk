defmodule Obelisk.Tasks.Server do
  
  @moduledoc """
  This task starts the Obelisk server

  ## Switches
  
  None.
  """

  def run(_) do
    Application.start :cowboy
    Application.start :plug
    IO.puts "Starting Cowboy server. Browse to http://localhost:4000/index.html"
    Plug.Adapters.Cowboy.http Obelisk.Plug.Server, []
    _continue
  end

  defp _continue, do: _continue

end
