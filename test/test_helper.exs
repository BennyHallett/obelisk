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

end
