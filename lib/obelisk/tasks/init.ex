defmodule Obelisk.Tasks.Init do
  
  @moduledoc """
  This task initializes a manapot project.

  ## Switches
  
  None.
  """

  def run(args) do
    create_assets_dirs
  end

  defp create_assets_dirs do
    File.mkdir("./assets")
    File.mkdir("./assets/css")
    File.mkdir("./assets/js")
    File.mkdir("./assets/img")
  end

end
