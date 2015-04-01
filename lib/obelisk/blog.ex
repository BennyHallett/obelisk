defmodule Obelisk.Blog do
  require Integer

  def compile_index(posts, store) do
    posts
    |> Enum.sort(&(&1.frontmatter.created <= &2.frontmatter.created))
    |> _compile_index(store)
  end

  defp _compile_index([], _, _), do: nil
  defp _compile_index(posts, store, page_num \\ 1) do
    { ppp, _ } = Integer.parse Obelisk.Config.config.posts_per_page
    { c, r } = Enum.split(posts, ppp)
    write_index_page c, page_num, last_page?(r), store
    _compile_index r, store, page_num + 1
  end

  defp write_index_page(posts, page_num, last_page, store) do
    templates = Obelisk.Store.get_layouts(store)
    { layout, layout_renderer } = templates.layout
    { index, index_renderer } = templates.index
    File.write(html_filename(page_num),
      Obelisk.Renderer.render(layout, [js: Obelisk.Assets.js, css: Obelisk.Assets.css, content: Obelisk.Renderer.render(index, [prev: previous_page(page_num), next: next_page(page_num, last_page), content: posts ], index_renderer)], layout_renderer))
  end

  defp last_page?([]), do: true
  defp last_page?(_),  do: false

  def html_filename(1),        do: "./build/index.html"
  def html_filename(page_num), do: "./build/index#{page_num}.html"

  defp previous_page(1),        do: ""
  defp previous_page(2),        do: "<a href=\"index.html\">Previous Page</a>"
  defp previous_page(page_num), do: "<a href=\"index#{page_num - 1}.html\">Previous Page</a>"

  defp next_page(_page_num, true),  do: ""
  defp next_page(page_num, false), do: "<a href=\"index#{page_num + 1}.html\">Next Page</a>"

end
