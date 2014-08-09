defmodule Obelisk.Page do

  def compile(md_file) do
    spawn_link fn ->
      Obelisk.Document.compile "./pages/#{md_file}", Obelisk.Layout.page
    end
  end

  def list do
    File.ls! "./pages"
  end

end
