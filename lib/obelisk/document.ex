defmodule Obelisk.Document do
  alias Obelisk.Document

  defstruct(
    path: nil,
    filename: nil,
    frontmatter: nil,
    content: nil,
    document: nil
  )

  defp parse_frontmatter(document, frontmatter_string) do
    %Document{
      document | frontmatter: Obelisk.FrontMatter.parse(frontmatter_string)
    }
  end

  defp render_content(document, content_string, layout) do
    params =
      [ filename: document.filename,
        frontmatter: document.frontmatter,
        content: Obelisk.Renderer.render(content_string)
      ]

    %Document{
      document | content: Obelisk.Renderer.render(layout, params)
    }
  end

  defp render_assets(document, js_assets, css_assets, layout) do
    params =
      [ js: js_assets,
        css: css_assets,
        content: document.content
      ]

    %Document{
      document | document: Obelisk.Renderer.render(layout, params)
    }
  end

  defp write_document_to_html(document) do
    File.write document.path, document.document
  end

  defp markdown_file_to_document(md_file, content_layout) do
    path = html_filename md_file
    filename = file_name md_file

    {frontmatter_string, content_string} = parts File.read!(md_file)

    layout = Obelisk.Layout.layout
    js_assets = Obelisk.Assets.js
    css_assets = Obelisk.Assets.css

    %Document{path: path, filename: filename}
    |> parse_frontmatter(frontmatter_string)
    |> render_content(content_string, content_layout)
    |> render_assets(js_assets, css_assets, layout)
  end

  def compile(md_file, content_layout) do
    md_file
    |> markdown_file_to_document(content_layout)
    |> write_document_to_html
  end

  def prepare(md_file, content_layout) do
    md_file
    |> markdown_file_to_document(content_layout)
    |> Map.from_struct
  end

  def write_all(pages) do
    Enum.each pages, fn page ->
      File.write page.path, page.document
    end
  end

  def file_name(md) do
    filepart = String.split("#{md}", "/") |> Enum.reverse |> hd
    String.replace(filepart, ".markdown", ".html")
  end

  def html_filename(md) do
    "./build/#{file_name(md)}"
  end

  def title(md) do
    md
    |> String.slice(11, 1000)
    |> String.replace("-", " ")
    |> String.replace(".markdown", "")
    |> String.capitalize
  end

  def parts(page_content) do
    [frontmatter|content] = String.split page_content, "\n---\n"
    { frontmatter, Enum.join(content, "\n") }
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
