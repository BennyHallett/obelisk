defmodule Obelisk.Blog do

  def compile_index([], _, _), do: nil
  def compile_index(posts, store, page_num \\ 1) do
    config = Obelisk.Store.get_config(store)
    { ppp, _ } = Integer.parse config.posts_per_page
    { c, r } = Enum.split(posts, ppp)
    write_index_page c, page_num, last_page?(r), store
    compile_index r, store, page_num + 1
  end

  defp write_index_page(posts, page_num, last_page, store) do
    templates = Obelisk.Store.get_layouts(store)
    File.write(html_filename(page_num),
      EEx.eval_string(templates.layout, assigns: [js: Obelisk.Assets.js, css: Obelisk.Assets.css, content: EEx.eval_string(templates.index, assigns: [prev: previous_page(page_num), next: next_page(page_num, last_page), content: Enum.map(posts, &(post_link &1))])]))
  end

  defp last_page?([]), do: true
  defp last_page?(_),  do: false

  def html_filename(1),        do: "./build/index.html"
  def html_filename(page_num), do: "./build/index#{page_num}.html"

  defp post_link(post), do: "<a href=\"#{post.filename}\">#{post.frontmatter.title}</a>"

  defp previous_page(1),        do: ""
  defp previous_page(2),        do: "<a href=\"index.html\">Previous Page</a>"
  defp previous_page(page_num), do: "<a href=\"index#{page_num - 1}.html\">Previous Page</a>"

  defp next_page(page_num, true),  do: ""
  defp next_page(page_num, false), do: "<a href=\"index#{page_num + 1}.html\">Next Page</a>"

end
