defmodule Obelisk.Tasks.Build do
  
  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  def run(args) do
    { :ok, files } = File.ls("./posts")
    File.rm_rf "./build"
    File.mkdir "./build"

    build_index Enum.reverse(files), div(Enum.count(files), 10) + 1
  end

  defp build_index(posts, accumulator) when accumulator <= 1 do
    Enum.each posts, &(Obelisk.Post.compile &1)
    # build index page
  end

  defp build_index(posts, accumulator) do
    { c, r } = Enum.split(posts, 10)
    Enum.each c, &(Obelisk.Post.compile &1)
    # build the index page off of c
    build_index(r, accumulator - 1)
  end

end
