defmodule Obelisk.Post do

  def compile(md_file) do
    { :ok, md } = File.read("./posts/#{md_file}")
    { :ok, template } = File.read("./layout/post.eex")
    { :ok, layout } = File.read("./layout/layout.eex")
    File.write(html_filename(md_file),
      EEx.eval_string(layout, assigns: [content: EEx.eval_string(template, assigns: [content: Markdown.to_html(md)])]))
  end

  def html_filename(md) do
    "./build/#{String.replace(md, ".markdown", ".html")}"
  end

end
