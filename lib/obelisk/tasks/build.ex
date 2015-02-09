defmodule Obelisk.Tasks.Build do

  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  def run(_) do
    Application.start :yamerl
    Obelisk.start(nil, nil)
    Obelisk.Site.clean
    Obelisk.Theme.ensure
    Obelisk.Assets.copy

    { :ok, store } = Obelisk.Store.start_link
    Obelisk.Page.list |> Enum.each &(Obelisk.Page.prepare(&1, store))
    Obelisk.Post.list |> Enum.each &(Obelisk.Post.prepare(&1, store))

    Obelisk.Document.write_all Obelisk.Store.get_pages(store)
    posts = Obelisk.Store.get_posts(store)
    Obelisk.Document.write_all posts
    Obelisk.RSS.build_feed posts
    Obelisk.Blog.compile_index(posts, store)
  end

end
