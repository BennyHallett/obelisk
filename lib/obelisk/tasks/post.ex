defmodule Obelisk.Tasks.Post do
  
  @moduledoc """
  This task creates a new post with the given post title argument as part of the filename,
  and included in the front matter title

  ## Arguments

  * Post title

  ## Usage

      $ mix obelisk post "This one wierd trick"
  """

  @doc """
  Run the build task
  """
  def run([]) do
    raise ArgumentError, message: "Cannot create a new post without the post name"
  end

  @doc """
  Run the build task
  """
  def run(args) do
    hd(args) |> Obelisk.Post.create
  end

end
