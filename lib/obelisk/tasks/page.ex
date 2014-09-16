defmodule Obelisk.Tasks.Page do
  
  @moduledoc """
  This task creates a new page with the given post title argument as part of the filename,
  and included in the front matter title

  ## Arguments

  * Page title

  ## Usage

      $ mix obelisk page "This one wierd trick"
  """

  @doc """
  Run the build task
  """
  def run([]), do: raise(ArgumentError, message: "Cannot create a new page without the post name")
  def run(args), do: hd(args) |> Obelisk.Page.create

end
