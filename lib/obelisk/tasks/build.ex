defmodule Obelisk.Tasks.Build do
  
  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  def run(args) do
    { :ok, files } = File.ls("./posts")
    IO.puts "Cleaning build directory"
    File.rm_rf "./build"
    File.mkdir "./build"

    IO.puts "Copying assets"
    Obelisk.Assets.copy

    IO.puts "Compiling blog"
    compile_blog(Enum.reverse(Enum.sort(files)), 1)
    IO.puts "Done"
  end

  defp compile_blog(posts, page_num) when posts == [] do
  end

  defp compile_blog(posts, page_num) do
    { c, r } = Enum.split(posts, 10)
    Enum.each c, &(Obelisk.Post.compile &1)
    Obelisk.Blog.compile_index c, page_num
    compile_blog r, page_num + 1
  end

end
