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
    Obelisk.Post.list |> Enum.sort |> Enum.reverse |> compile_blog 1, []
  end

  defp compile_blog([], _, rss_items) do
    channel = RSS.channel '1', '2', '3', '4', '5'
    File.write("./build/blog.rss", RSS.feed(channel, rss_items))
  end

  defp compile_blog(posts, page_num, rss_items) do
    { c, r } = Enum.split(posts, 10)
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

end
