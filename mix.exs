defmodule Obelisk.Mixfile do
  use Mix.Project

  def project do
    [app: :obelisk,
     version: "0.7.1",
     elixir: "~> 1.0.0",
     package: package,
     docs: [readme: true, main: "README.md"],
     description: """
      obelisk is a static site generator for Elixir. It is inspired by jekyll,
      with the goal of being fast and simple to use and extend.
     """,
     deps: deps]
  end

  def application do
    [applications: [:yamerl, :cowboy, :plug],
     mod: {Obelisk, []}]
  end

  defp deps do
    [{:yamerl, github: "yakaz/yamerl"},
     {:earmark, "~> 0.1.10"},
     {:chronos, "~> 0.3.7"},
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 0.8.0"},
     {:rss, "~> 0.2.1"},
     {:anubis, "~> 0.1.0"}]
  end

  defp package do
    %{
      licenses: ["MIT"],
      contributors: ["Benny Hallett"],
      links: %{ "Github" => "https://github.com/bennyhallett/obelisk"}
    }
  end
end
