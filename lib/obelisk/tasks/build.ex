defmodule Obelisk.Tasks.Build do

  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  defp is_hidden(<<".", _::binary>>), do: true
  defp is_hidden(_),                  do: false

  defp is_page_filename(filename) do
    not is_hidden(filename)
  end

  defp is_post_filename(filename) do
    try do
      <<_year::4*8,  "-",
        _month::2*8, "-",
        _day::2*8,   "-",
        title_and_extension::binary
      >> = filename

      [title, "markdown"] = String.split title_and_extension, "."

      Regex.match? ~r/^\S+$/, title

    rescue
      MatchError ->
        false
    end
  end

  def run(_) do
    Application.start :yamerl
    Obelisk.start(nil, nil)
    Obelisk.Site.clean
    Obelisk.Theme.ensure
    Obelisk.Assets.copy

    { :ok, store } = Obelisk.Store.start_link

    Obelisk.Page.list
    |> Enum.filter(&is_page_filename(&1))
    |> Enum.each(&Obelisk.Page.prepare(&1, store))

    Obelisk.Post.list
    |> Enum.filter(&is_post_filename(&1))
    |> Enum.each(&Obelisk.Post.prepare(&1, store))

    Obelisk.Document.write_all Obelisk.Store.get_pages(store)
    posts = Obelisk.Store.get_posts(store)
    Obelisk.Document.write_all posts
    Obelisk.RSS.build_feed posts
    Obelisk.Blog.compile_index(posts, store)
  end

end
