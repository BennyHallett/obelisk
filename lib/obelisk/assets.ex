defmodule Obelisk.Assets do

  def copy do
    File.cp_r "./assets", "./build/assets"
  end

  def css_files do
    paths = File.ls!("./build/assets/css") |> Enum.sort |> Enum.map &("assets/css/#{&1}")
    Enum.filter(paths, &(!File.dir? &1))
  end

  def js_files do
    paths = File.ls!("./build/assets/js") |> Enum.sort |> Enum.map &("assets/js/#{&1}")
    Enum.filter(paths, &(!File.dir? &1))
  end

  def css do
    Enum.map(css_files, &("<link rel=\"stylesheet\" href=\"#{&1}\" />") )|> Enum.join("\n")
  end

  def js do
    Enum.map(js_files, &("<script type=\"text/javascript\" src=\"#{&1}\"></script>")) |> Enum.join("\n")
  end

end
