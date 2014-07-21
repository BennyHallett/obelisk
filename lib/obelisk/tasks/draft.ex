defmodule Obelisk.Tasks.Draft do
  
  @moduledoc """
  This task creates a new draft with the given post title argument as part of the filename,
  and included in the front matter title

  ## Arguments

  * Draft title

  ## Usage

      $ mix obelisk draft "Still working on this"
  """

  @doc """
  Run the draft task
  """
  def run([]) do
    raise ArgumentError, message: "Cannot create a new draft without the post name"
  end

  @doc """
  Run the draft task
  """
  def run(args) do
    hd(args) |> Obelisk.Draft.create
  end

end
