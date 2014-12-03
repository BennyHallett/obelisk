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
    { :ok, pid } = Plug.Adapters.Cowboy.http Obelisk.Plug.Server, []

    wait_til_dead pid
  end

  defp wait_til_dead(pid), do: _wait_til_dead(pid, Process.alive?(pid))
  defp _wait_til_dead(pid, true), do: _wait_til_dead(pid, Process.alive?(pid))
  defp _wait_til_dead(_, _), do: nil

end
