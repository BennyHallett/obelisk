ExUnit.start()

defmodule TestHelper do

  def cleanup do
    File.rm_rf "./assets"
    File.rm_rf "./posts"
    File.rmdir "./drafts"
    File.rmdir "./pages"
    File.rmdir "./layout"
    File.rm "./site.yml"
    File.rm_rf "./build"
  end

  def datepart do 
    today = Chronos.today
    month = today |> Chronos.Formatter.strftime("%m") |> String.rjust(2, ?0)
    day = today |> Chronos.Formatter.strftime("%d") |> String.rjust(2, ?0)
    today |> Chronos.Formatter.strftime("%Y-#{month}-#{day}")  
  end

end
