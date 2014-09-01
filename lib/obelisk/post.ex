defmodule Obelisk.Post do

  def compile(md_file) do
    spawn_link fn ->
      Obelisk.Document.compile "./posts/#{md_file}", Obelisk.Layout.post
    end
  end

  def prepare(md_file, store) do
    layouts = Obelisk.Store.get_layouts(store)
    Obelisk.Store.add_posts(store, [ Obelisk.Document.prepare("./posts/#{md_file}", layouts.post) ])
  end

  def title(md) do
    String.capitalize(String.replace(String.replace(String.slice(md, 11, 1000), "-", " "), ".markdown", ""))
  end

  def list do
    File.ls!("./posts")
    |> Enum.sort
    |> Enum.reverse
  end

  def create(title) do
    File.write(filename_from_title(title), Obelisk.Templates.post(title))
  end

  def filename_from_title(title) do
    datepart = Chronos.today |> Chronos.Formatter.strftime("%Y-%0m-%0d")
    titlepart = String.downcase(title) |> String.replace(" ", "-")
    "./posts/#{datepart}-#{titlepart}.markdown"
  end

end
