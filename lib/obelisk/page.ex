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

  def create(title) do
    File.write(filename_from_title(title), Obelisk.Templates.page(title))
  end

  def filename_from_title(title) do
    titlepart = String.downcase(title) |> String.replace(" ", "-")
    "./pages/#{titlepart}.markdown"
  end

end
