defmodule Obelisk.Mixfile do
  use Mix.Project

  def project do
    [app: :obelisk,
     version: "0.0.1",
     elixir: "~> 0.14.1",
     package: package,
     docs: [readme: true, main: "README.md"],
     description: """
      obelisk is a static site generator for Elixir. It is inspired by jekyll,
      with the goal of being fast and simple to use and extend.
     """,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:markdown, github: "devinus/markdown"}]
  end

  defp package do
    %{
      licences: ["MIT"],
      links: %{ "Github" => "https://github.com/bennyhallett/obelisk"}
    }
  end
end
