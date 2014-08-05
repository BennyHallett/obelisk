defmodule Obelisk.Config do

  def config do
    unless File.exists? "site.yml" do raise(RuntimeError, message: "Couldn't find configuration file: site.yml") end
    yaml = File.read! "site.yml"
    Obelisk.YamlToDict.convert %{}, hd(:yamerl_constr.string(yaml))
  end

end
