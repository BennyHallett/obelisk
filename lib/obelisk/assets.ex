defmodule Obelisk.Assets do
  alias Obelisk.Theme

  def copy, do: File.cp_r("./themes/#{Theme.current}/assets", "./build/assets")

  def css_files do
    File.ls!("./build/assets/css")
    |> Enum.sort
    |> Enum.map(&("assets/css/#{&1}"))
    |> Enum.filter(&(!File.dir? "./build/#{&1}"))
  end

  def js_files do
    File.ls!("./build/assets/js")
    |> Enum.sort
    |> Enum.map(&("assets/js/#{&1}"))
    |> Enum.filter(&(!File.dir? "./build/#{&1}"))
  end

  def css do
    css_files
    |> Enum.map(&("<link rel=\"stylesheet\" href=\"#{&1}\" />"))
    |> Enum.join("\n")
  end

  def js do
    js_files
    |> Enum.map(&("<script type=\"text/javascript\" src=\"#{&1}\"></script>"))
    |> Enum.join("\n")
  end

end
