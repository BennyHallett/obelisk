defmodule Obelisk.Layout do
  alias Obelisk.Theme

  def path do
    "./themes/#{Theme.current}/layout/layout.eex"
  end

  def layout, do: load "layout"

  def post, do: load "post"

  def page, do: load "page"

  def index, do: load "index"

  defp load(template) do
    template
    |> to_filename
    |> to_path
    |> read
    |> determine_renderer
  end

  defp base_path do
    "./themes/#{Theme.current}/layout"
  end

  defp to_filename(template) do
    base_path
    |> File.ls!
    |> Enum.find(fn(t) -> hd(String.split(t, ".")) == template end)
  end

  defp to_path(filename), do: base_path <> "/" <> filename

  defp read(path), do: { File.read!(path), path }

  defp determine_renderer({ content, path }) do
    renderer = path
    |> String.split(".")
    |> Enum.reverse
    |> hd
    |> String.to_atom

    { content, renderer }
  end

end
