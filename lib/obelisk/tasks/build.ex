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

    # Split into groups of 10 and call build_index
    build_index Enum.reverse(files), div(Enum.count(files), 10) + 1
  end

  defp build_page(md_file) do
    { :ok, md } = File.read("./posts/#{md_file}")
    { :ok, template } = File.read("./layout/post.eex")
    { :ok, layout } = File.read("./layout/layout.eex")
    File.write(html_filename(md_file), 
      EEx.eval_string(layout, assigns: [content: EEx.eval_string(template, assigns: [content: Markdown.to_html(md)])]))
  end

  defp build_index(posts, accumulator) when accumulator <= 1 do
    Enum.each posts, &(build_page &1)
    # build index page
  end

  defp build_index(posts, accumulator) do
    { c, r } = Enum.split(posts, 10)
    Enum.each c, &(build_page &1)
    # build the index page off of c
    build_index(r, accumulator - 1)
  end

  defp html_filename(md) do
    "./build/#{String.replace(md, ".markdown", ".html")}"
  end

end
