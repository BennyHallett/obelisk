defmodule Obelisk.Tasks.Server do
  
  @moduledoc """
  This task starts the Obelisk server

  ## Switches
  
  None.
  """

  def run(_) do
    Application.start :cowboy
    Application.start :plug
    IO.puts "Starting Cowboy server. Browse to http://localhost:4000/"
    IO.puts "Press <CTRL+C> <CTRL+C> to quit."
    { :ok, _pid } = Plug.Adapters.Cowboy.http Obelisk.Plug.Server, []

    :timer.sleep(:infinity)
  end

end
