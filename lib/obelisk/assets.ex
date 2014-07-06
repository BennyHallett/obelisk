defmodule Obelisk.Assets do

  def copy do
    File.cp_r "./assets", "./build/assets"
  end

end
