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
    contents = Enum.map(files, fn a ->
      { :ok, md } = File.read("./posts/#{a}")
      { :ok, template } = File.read("./layout/post.eex")
      { :ok, layout } = File.read("./layout/layout.eex")
      File.write("./build/#{String.replace(a, ".markdown", ".html")}", 
        EEx.eval_string(layout, assigns: [content: EEx.eval_string(template, assigns: [content: Markdown.to_html(md)])]))
    end)
  end

end
