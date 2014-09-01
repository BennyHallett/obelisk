defmodule Obelisk.Blog do

  def compile_index([], _, _) do
  end

  def compile_index(posts, store, page_num \\ 1) do
    config = Obelisk.Store.get_config(store)
    { ppp, _ } = Integer.parse config.posts_per_page
    { c, r } = Enum.split(posts, ppp)
    write_index_page c, page_num, last_page?(r), store
    compile_index r, store, page_num + 1
  end

  defp last_page?([]) do
    true
  end

  defp last_page?(_) do
    false
  end

  defp write_index_page(posts, page_num, last_page, store) do
    templates = Obelisk.Store.get_layouts(store)
    File.write(html_filename(page_num),
      EEx.eval_string(templates.layout, assigns: [js: Obelisk.Assets.js, css: Obelisk.Assets.css, content: EEx.eval_string(templates.index, assigns: [prev: previous_page(page_num), next: next_page(page_num, last_page), content: Enum.map(posts, &(post_link &1))])]))
  end

  def html_filename(1) do
    "./build/index.html"
  end

  def html_filename(page_num) do
    "./build/index#{page_num}.html"
  end

  defp post_link(post) do
    "<a href=\"#{post.filename}\">#{post.frontmatter.title}</a>"
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

  defp next_page(page_num, true) do
    ""
  end

  defp next_page(page_num, false) do
    "<a href=\"index#{page_num + 1}.html\">Next Page</a>"
  end

end
