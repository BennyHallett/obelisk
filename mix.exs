defmodule Obelisk.Mixfile do
  use Mix.Project

  def project do
    [app: :obelisk,
     version: "0.10.0",
     elixir: "~> 1.0",
     package: package,
     docs: [readme: true, main: "README.md"],
     description: """
      obelisk is a static site generator for Elixir. It is inspired by jekyll,
      with the goal of being fast and simple to use and extend.
     """,
     deps: deps]
  end

  def application do
    [applications: [:yamerl, :cowboy, :plug, :chronos],
     mod: {Obelisk, []}]
  end

  defp deps do
    [{:yamerl, "~> 0.4.0"},
     {:earmark, "~> 0.1.15"},
     {:chronos, "~> 1.7.0"},
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.2.0"},
     {:rss, "~> 0.2.1"},
     {:anubis, "~> 0.1.0"},
     {:mock, "~> 0.1.0"},
     {:calliope, "~> 0.3.0"}]
  end

  defp package do
    %{
      licenses: ["MIT"],
      contributors: ["Benny Hallett"],
      links: %{ "Github" => "https://github.com/bennyhallett/obelisk"}
    }
  end
end
