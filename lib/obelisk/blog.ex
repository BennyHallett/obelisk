defmodule Obelisk.Blog do
  require Integer

  defp get_sort_order do
    Obelisk.Config.config[:sort_posts]
  end

  defp sort_by_created(:ascending) do
    &(&1.frontmatter.created <= &2.frontmatter.created)
  end
  defp sort_by_created(:descending) do
    &(&1.frontmatter.created >= &2.frontmatter.created)
  end

  defp get_sort_function do
    case get_sort_order do
      "descending" ->
        sort_by_created :descending

      "ascending" ->
        sort_by_created :ascending

      _ ->
        sort_by_created :ascending
    end
  end

  def compile_index(posts, store) do
    Obelisk.Config.config
    |> Dict.get(:blog_index)
    |> make_path

    posts
    |> Enum.sort(get_sort_function)
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

  def html_filename(page_num) do
    Obelisk.Config.config
    |> Dict.get(:blog_index)
    |> with_index_num(page_num)
    |> build_index_path
  end

  defp with_index_num(nil, 1), do: "index.html"
  defp with_index_num(nil, page_num), do: "index#{page_num}.html"
  defp with_index_num(c, 1), do: c
  defp with_index_num(c, page_num) do
    [ext|reverse_path] = c
    |> String.split(".")
    |> Enum.reverse

    p = reverse_path
    |> Enum.reverse
    |> Enum.join

    p <> to_string(page_num) <> "." <> ext
  end

  defp make_path(nil), do: nil
  defp make_path(path) do
    path
    |> String.split("/")
    |> Enum.reverse
    |> _make_path
  end

  defp _make_path([_filename|[]]), do: nil
  defp _make_path([_filename|reverse_path]) do
    [reverse_path] ++ ["build", "."] # Will reverse to ./build/path/unreversed
    |> Enum.reverse
    |> Enum.join("/")
    |> File.mkdir_p
  end

  defp build_index_path(path), do: "./build/" <> path

  defp build_link(path, text), do: "<a href=\"#{path}\">#{text}</a>"

  def previous_page(1),        do: ""
  def previous_page(page_num) do
    Obelisk.Config.config
    |> Dict.get(:blog_index)
    |> with_index_num(page_num - 1)
    |> build_link("Previous Page")
  end

  def next_page(_page_num, true),  do: ""
  def next_page(page_num,  false) do
    Obelisk.Config.config
    |> Dict.get(:blog_index)
    |> with_index_num(page_num + 1)
    |> build_link("Next Page")
  end

end
