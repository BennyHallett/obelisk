defmodule Obelisk.Draft do

  def compile(md_file) do
    Obelisk.Document.compile "./drafts/#{md_file}", Obelisk.Layout.post
  end

  def title(md) do
    String.capitalize(String.replace(String.replace(String.slice(md, 11, 1000), "-", " "), ".markdown", ""))
  end

  def list do
    File.ls! "./drafts"
  end

  def create(title) do
    File.write(filename_from_title(title), Obelisk.Templates.post(title))
  end

  def filename_from_title(title) do
    datepart = Chronos.today |> Chronos.Formatter.strftime("%Y-%0m-%0d")
    titlepart = String.downcase(title) |> String.replace(" ", "-")
    "./drafts/#{datepart}-#{titlepart}.markdown"
  end

end
