defmodule Obelisk.Mixfile do
  use Mix.Project

  def project do
    [app: :obelisk,
     version: "0.1.0",
     elixir: "~> 0.14.2",
     package: package,
     docs: [readme: true, main: "README.md"],
     description: """
      obelisk is a static site generator for Elixir. It is inspired by jekyll,
      with the goal of being fast and simple to use and extend.
     """,
     deps: deps]
  end

  def application do
    [applications: [:yamerl]]
  end

  defp deps do
    [{:yamerl, github: "yakaz/yamerl"},
     {:markdown, github: "devinus/markdown"},
     {:chronos, "~> 0.3.2"}]
  end

  defp package do
    %{
      licences: ["MIT"],
      links: %{ "Github" => "https://github.com/bennyhallett/obelisk"}
    }
  end
end
