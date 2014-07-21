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
    opts = OptionParser.parse(args)
    case elem(opts, 1) do
      [] -> raise Mix.Error, message: "expected COMMAND to be given"
      [cmd|tail] ->
        validate_cmd! cmd
       case cmd do
        "init" -> Obelisk.Tasks.Init.run(tail)
        "build" -> Obelisk.Tasks.Build.run(tail)
        "post" -> Obelisk.Tasks.Post.run(tail)
        "draft" -> Obelisk.Tasks.Draft.run(tail)
      end
    end
  end

  defp validate_cmd!(cmd) do
    valid = Enum.any? ["init", "build", "server", "draft", "post", "page", "help"], &(&1 == cmd)
    unless valid do raise Mix.Error, message: "the command `#{cmd}` is not known." end
  end

end
