defmodule Obelisk.Tasks.Build do
  
  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  def run(args) do
    Application.start :yamerl
    Obelisk.Site.clean
    Obelisk.Assets.copy
    Obelisk.Page.list |> Enum.each &(Obelisk.Page.compile &1)
    Obelisk.Post.list |> Enum.sort |> Enum.reverse |> compile_blog(1, [])
  end

  defp compile_blog([], _, rss_items) do
    config = Obelisk.Config.config
    channel = RSS.channel(
      Dict.get(config, :name),
      Dict.get(config, :url),
      Dict.get(config, :description),
      Chronos.Formatter.strftime(Chronos.now, "%Y-%0m-%0d %H:%M:%S"),
      Dict.get(config, :language, "en-us"))
    File.write("./build/blog.rss", RSS.feed(channel, rss_items))
  end

  defp compile_blog(posts, page_num, rss_items) do
    { c, r } = Enum.split(posts, posts_per_page)
    Enum.each c, &(Obelisk.Post.compile &1)
    Obelisk.Blog.compile_index c, page_num, last_page?(r)
    items = Obelisk.RSS.compile_rss c, rss_items
    compile_blog r, page_num + 1, items
  end

  defp last_page?([]) do
    true
  end

  defp last_page?(_) do
    false
  end

  defp posts_per_page do
    Obelisk.Config.config.posts_per_page |> String.to_integer
  end

end
