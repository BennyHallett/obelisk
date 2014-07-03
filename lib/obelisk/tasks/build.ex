defmodule Obelisk.Tasks.Build do
  
  @moduledoc """
  This task builds the output of your static site

  ## Switches
  
  None.
  """

  def run(args) do
    { :ok, files } = File.ls("./posts")
    File.mkdir "./build"
    contents = Enum.map(files, fn a ->
      { :ok, md } = File.read("./posts/#{a}")
      File.write("./build/#{String.replace(a, ".markdown", ".html")}", Markdown.to_html(md))
    end)
  end

end
