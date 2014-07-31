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
    Obelisk.Post.list |> Enum.sort |> Enum.reverse |> compile_blog 1
  end

  defp compile_blog([], _) do
  end

  defp compile_blog(posts, page_num) do
    { c, r } = Enum.split(posts, 10)
    Enum.each c, &(Obelisk.Post.compile &1)
    Obelisk.Blog.compile_index c, page_num, last_page?(r)
    compile_blog r, page_num + 1
  end

  defp last_page?([]) do
    true
  end

  defp last_page?(_) do
    false
  end

end
