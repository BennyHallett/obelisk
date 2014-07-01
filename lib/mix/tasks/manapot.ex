defmodule Mix.Tasks.Manapot do
  use Mix.Task

  @shortdoc "Run manapot tasks."
  @moduledoc """
  Runs manapot tasks.

  ##Available tasks

  $ mix manapot init      - Creates the scaffolding for the static site
  $ mix manapot build     - Compile the site to the ./site directory
  $ mix manapot server    - Run a server to view the static site
  $ mix manapot draft     - Create a new draft post
  $ mix manapot post
  $ mix manapot page
  $ mix manapot help
  """

  def run(args) do
    IO.puts("this is a test")
  end

end
