defmodule Obelisk.Tasks.Init do
  
  @moduledoc """
  This task initializes a manapot project.

  ## Switches
  
  None.
  """

  def run(args) do
    create_assets_dirs
    create_content_dirs
    create_layout_dirs
    date = String.rstrip(System.cmd("date +%Y-%m-%d"))
    File.write "./posts/#{date}-welcome-to-obelisk.markdown", Obelisk.Templates.post
    File.write './site.yml', Obelisk.Templates.config
  end

  defp create_assets_dirs do
    File.mkdir "./assets"
    File.mkdir "./assets/css"
    File.mkdir "./assets/js"
    File.mkdir "./assets/img"
    File.write "./assets/css/base.css", Obelisk.Templates.base_css
  end

  defp create_content_dirs do
    File.mkdir "./posts"
    File.mkdir "./drafts"
    File.mkdir "./pages"
  end

  defp create_layout_dirs do
    File.mkdir "./layout"
    File.write "./layout/post.eex", Obelisk.Templates.post_template
    File.write "./layout/layout.eex", Obelisk.Templates.layout
    File.write "./layout/index.eex", Obelisk.Templates.index
  end

end
