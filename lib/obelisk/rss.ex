defmodule Obelisk.RSS do

  def compile_rss(posts, accumulator) do
    n = posts |> Enum.map &(build_item &1)
    accumulator ++ n
  end

  defp build_item(post) do
    md = File.read! "./posts/#{post}"
    { frontmatter, md_content } =  Obelisk.Document.parts md
    fm = Obelisk.FrontMatter.parse frontmatter
    RSS.item fm.title, fm.description, "Date", "link", "link"
  end

end
