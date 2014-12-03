defmodule Obelisk.Config do
  use GenServer

  ## External API
  def start_link(_), do: GenServer.start_link(__MODULE__, load_config, name: __MODULE__)

  def reload, do: GenServer.cast(__MODULE__, :reload)

  def config, do: GenServer.call(__MODULE__, :config)

  def force(new_config), do: GenServer.cast(__MODULE__, { :force, new_config })

  ## GenServer callbacks

  def handle_call(:config, _from, config), do: { :reply, config, config }

  def handle_cast({:force, new_config}, _config), do: { :noreply, new_config }

  def handle_cast(:reload, _config), do: { :noreply, load_config }
  ## Helpers

  defp load_config, do: _load_config(File.read("site.yml"))

  defp _load_config({ :error, _ }), do: { :ok, Obelisk.Templates.config } |> _load_config
  defp _load_config({ :ok, content }), do: Obelisk.YamlToDict.convert(%{}, hd(:yamerl_constr.string(content)))

end
