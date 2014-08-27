defmodule Obelisk.Page do

  def compile(md_file) do
    spawn_link fn ->
      Obelisk.Document.compile "./pages/#{md_file}", Obelisk.Layout.page
    end
  end

  def prepare(md_file, store) do
    layouts = Obelisk.Store.get_layouts(store)
    Obelisk.Store.add_pages(store, [ Obelisk.Document.prepare("./pages/#{md_file}", layouts.page) ])
  end

  def list do
    File.ls! "./pages"
  end

end
