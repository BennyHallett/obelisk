defmodule Obelisk.RSS do

  def compile_rss(posts, accumulator) do
    n = posts |> Enum.map &(build_item &1)
    accumulator ++ n
  end

  defp build_item(post) do
    config = Obelisk.Config.config
    url = Dict.get(config, :url, "") <> "/" <> String.replace(post, ".markdown", ".html")
    md = File.read! "./posts/#{post}"
    { frontmatter, md_content } =  Obelisk.Document.parts md
    fm = Obelisk.FrontMatter.parse frontmatter
    RSS.item(
      Dict.get(fm, :title),
      Dict.get(fm, :description),
      String.slice(post, 0, 10),
      url,
      url)
  end

end
