defmodule Obelisk.Assets do

  def copy do
    File.cp_r "./assets", "./build/assets"
  end

  def css_files do
    Enum.map(File.ls!("./build/assets/css"), &("assets/css/#{&1}"))
  end

  def css do
    Enum.join(Enum.map(css_files, &("<link rel=\"stylesheet\" href=\"#{&1}\" />")), "\n")
  end

end
