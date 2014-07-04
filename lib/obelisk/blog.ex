defmodule Obelisk.Blog do

  def compile_index(posts, page_num) do
    { :ok, template } = File.read("./layout/index.eex")
    { :ok, layout } = File.read("./layout/layout.eex")
    File.write(html_filename(page_num),
      EEx.eval_string(layout, assigns: [content: EEx.eval_string(template, assigns: [content: Enum.map(posts, &(post_link &1))])]))
  end

  def html_filename(page_num) when page_num <= 1 do
    "./build/index.html"
  end

  def html_filename(page_num) do
    "./build/index#{page_num}.html"
  end

  defp post_link(post) do
    "<a href=\"#{String.slice(Obelisk.Post.html_filename(post), 8, 1000)}\">#{Obelisk.Post.title(post)}</a>"
  end

end
