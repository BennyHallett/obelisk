defmodule Obelisk.Draft do

  def compile(md_file) do
    Obelisk.Document.compile "./drafts/#{md_file}", Obelisk.Layout.post
  end

  def title(md) do
    md
    |> String.slice(11, 1000)
    |> String.replace("-", " ")
    |> String.replace(".markdown", "")
    |> String.capitalize
  end

  def list do
    File.ls! "./drafts"
  end

  def create(title) do
    File.write filename_from_title(title), Obelisk.Templates.post(title)
  end

  def filename_from_title(title) do
    datepart = Chronos.today |> Chronos.Formatter.strftime("%Y-%0m-%0d")
    titlepart =
      title
      |> String.downcase
      |> String.replace(" ", "-")

    "./drafts/#{datepart}-#{titlepart}.markdown"
  end

end
