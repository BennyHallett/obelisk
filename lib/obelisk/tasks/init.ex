defmodule Obelisk.Tasks.Init do
  
  @moduledoc """
  This task initializes a manapot project.

  ## Switches
  
  None.
  """

  def run(args) do
    Obelisk.Site.initialize
  end

end
