defmodule Mix.Tasks.Obelisk do
  use Mix.Task

  @shortdoc "Run obelisk tasks."
  @moduledoc """
  Runs obelisk tasks.

  ## Available tasks

  * $ mix obelisk init      - Creates the scaffolding for the static site
  * $ mix obelisk build     - Compile the site to the ./site directory
  * $ mix obelisk server    - Run a server to view the static site
  * $ mix obelisk draft     - Create a new draft
  * $ mix obelisk post      - Create a new post
  * $ mix obelisk page      - Create a new page
  * $ mix obelisk help      - Show help for a specific task
  """
  def run(args) do
    OptionParser.parse(args)
    |> elem(1)
    |> _run
  end

  defp _run(["init" |args]), do: Obelisk.Tasks.Init.run(args)
  defp _run(["build"|args]), do: Obelisk.Tasks.Build.run(args)
  defp _run(["post" |args]), do: Obelisk.Tasks.Post.run(args)
  defp _run(["draft"|args]), do: Obelisk.Tasks.Draft.run(args)
  defp _run([cmd|args]),       do: raise(Mix.Error, message: "the command `#{cmd}` is not known.")

end
