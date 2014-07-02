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
    File.write './config.yml', config_content
  end

  defp create_assets_dirs do
    File.mkdir "./assets"
    File.mkdir "./assets/css"
    File.mkdir "./assets/js"
    File.mkdir "./assets/img"
  end

  defp create_content_dirs do
    File.mkdir "./posts"
    File.mkdir "./drafts"
    File.mkdir "./pages"
  end

  defp create_layout_dirs do
    File.mkdir "./layout"
  end

  defp config_content do
    """
    ---
    name: A brand new static site

    """
  end

end
