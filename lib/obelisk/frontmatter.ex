defmodule Obelisk.FrontMatter do

  def parse(yaml) do
    Obelisk.YamlToDict.convert %{}, hd(:yamerl_constr.string(yaml)) 
  end

end
