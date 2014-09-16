ExUnit.start()

defmodule TestHelper do

  def cleanup do
    File.rm_rf "./assets"
    File.rm_rf "./posts"
    File.rm_rf "./drafts"
    File.rm_rf "./pages"
    File.rm_rf "./layout"
    File.rm "./site.yml"
    File.rm_rf "./build"
  end

  def datepart do 
    Chronos.today |> Chronos.Formatter.strftime("%Y-%0m-%0d")
  end

end
