defmodule Mix.Tasks.Obelisk do
  use Anubis

  @shortdoc "Run obelisk tasks."
  @moduledoc """
  Runs obelisk tasks.

  To view available commands, run:

      $ mix obelisk help
  """

  command :init,   "Creates the scaffolding for the static site", Obelisk.Tasks.Init.run
  command :build,  "Compile the site to the ./build directory",   Obelisk.Tasks.Build.run
  command :post,   "Create a new post",                           Obelisk.Tasks.Post.run
  command :draft,  "Create a new draft",                          Obelisk.Tasks.Draft.run
  command :server, "Start a local server to host the site",       Obelisk.Tasks.Server.run

  parse

end
