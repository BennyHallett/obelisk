defmodule Obelisk.Config do

  def config, do: _config(File.read("site.yml"))

  def _config({ :error, _ }), do: raise(RuntimeError, message: "Couldn't find configuration file: site.yml")
  def _config({ :ok, content }), do: Obelisk.YamlToDict.convert(%{}, hd(:yamerl_constr.string(content)))

end
