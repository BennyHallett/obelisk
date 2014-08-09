defmodule Obelisk.Page do

  #def compile(md_file) do
  #  spawn_link fn ->
  #    Obelisk.Document.compile md_file, Obelisk.Layout.page
  #  end
  #end

  def list do
    File.ls! "./pages"
  end

  #def create(title) do
  #  File.write(filename_from_title(title), Obelisk.Templates.post(title))
  #end

  #def filename_from_title(title) do
  #  datepart = Chronos.today |> Chronos.Formatter.strftime("%Y-%0m-%0d")
  #  titlepart = String.downcase(title) |> String.replace(" ", "-")
  #  "./posts/#{datepart}-#{titlepart}.markdown"
  #end

end
