defmodule Obelisk.Post do

  def compile(md_file) do
    { :ok, md } = File.read("./posts/#{md_file}")
    { frontmatter, md_content } =  parts(md)
    fm = Obelisk.FrontMatter.parse(frontmatter)
    { :ok, template } = File.read("./layout/post.eex")
    { :ok, layout } = File.read("./layout/layout.eex")
    File.write(html_filename(md_file),
      EEx.eval_string(layout, assigns: [js: Obelisk.Assets.js, css: Obelisk.Assets.css, content: EEx.eval_string(template, assigns: [content: Markdown.to_html(md_content)] ++ fm)]))
  end

  def html_filename(md) do
    "./build/#{String.replace(md, ".markdown", ".html")}"
  end

  def title(md) do
    String.capitalize(String.replace(String.replace(String.slice(md, 11, 1000), "-", " "), ".markdown", ""))
  end

  def list do
    File.ls! "./posts"
  end

  def parts(page_content) do
    [frontmatter|content] = String.split page_content, "\n---\n"
    { frontmatter, Enum.join(content, "\n") }
  end

  def create(title) do
    File.write(filename_from_title(title), Obelisk.Templates.post(title))
  end

  def filename_from_title(title) do
    today = Chronos.today
    month = today |> Chronos.Formatter.strftime("%m") |> String.rjust(2, ?0)
    day = today |> Chronos.Formatter.strftime("%d") |> String.rjust(2, ?0)
    datepart = today |> Chronos.Formatter.strftime("%Y-#{month}-#{day}")
    titlepart = String.downcase(title) |> String.replace(" ", "-")
    "./posts/#{datepart}-#{titlepart}.markdown"
  end

end
