defmodule Obelisk.Assets do

  def copy do
    File.cp_r "./assets", "./build/assets"
  end

  def css_files do
    Enum.map(File.ls!("./build/assets/css"), &("assets/css/#{&1}"))
  end

  def js_files do
    Enum.map(File.ls!("./build/assets/js"), &("assets/js/#{&1}"))
  end

  def css do
    Enum.join(Enum.map(css_files, &("<link rel=\"stylesheet\" href=\"#{&1}\" />")), "\n")
  end

  def js do
    Enum.join(Enum.map(js_files, &("<script type=\"text/javascript\" src=\"#{&1}\"></script>")), "\n")
  end

end
