defmodule Obelisk.RSS do

  def build_feed(posts) do
    config = Obelisk.Config.config
    channel = RSS.channel(
      Dict.get(config, :name),
      Dict.get(config, :url),
      Dict.get(config, :description),
      Chronos.Formatter.strftime(Chronos.now, "%Y-%0m-%0d %H:%M:%S"),
      Dict.get(config, :language, "en-us"))
    File.write("./build/blog.rss", RSS.feed(channel, compile_rss(posts)))
  end

  defp compile_rss(posts) do
    posts |> Enum.map &(build_item &1)
  end

  defp build_item(post) do
    config = Obelisk.Config.config
    url = Dict.get(config, :url, "") <> "/" <> post.filename
    RSS.item(
      Dict.get(post.frontmatter, :title),
      Dict.get(post.frontmatter, :description),
      String.slice(post.filename, 0, 10),
      url,
      url)
  end

end
