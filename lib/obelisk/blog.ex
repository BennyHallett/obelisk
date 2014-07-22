defmodule Obelisk.Blog do

  def compile_index(posts, page_num) do
    { :ok, template } = File.read("./layout/index.eex")
    { :ok, layout } = File.read("./layout/layout.eex")
    File.write(html_filename(page_num),
      EEx.eval_string(layout, assigns: [js: Obelisk.Assets.js, css: Obelisk.Assets.css, content: EEx.eval_string(template, assigns: [prev: previous_page(page_num), next: next_page(page_num), content: Enum.map(posts, &(post_link &1))])]))
  end

  def html_filename(page_num) when page_num <= 1 do
    "./build/index.html"
  end

  def html_filename(page_num) do
    "./build/index#{page_num}.html"
  end

  defp post_link(post) do
    "<a href=\"#{String.slice(Obelisk.Document.html_filename(post), 8, 1000)}\">#{Obelisk.Post.title(post)}</a>"
  end

  defp previous_page(1) do
    ""
  end

  defp previous_page(2) do
    "<a href=\"index.html\">Previous Page</a>"
  end

  defp previous_page(page_num) do
    "<a href=\"index#{page_num - 1}.html\">Previous Page</a>"
  end

  defp next_page(page_num) do
    "<a href=\"index#{page_num + 1}.html\">Next Page</a>"
  end

end
