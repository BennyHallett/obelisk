defmodule Obelisk.FrontMatter do

  def parse(yaml) do
    hd(:yamerl_constr.string(yaml))
  end

end
