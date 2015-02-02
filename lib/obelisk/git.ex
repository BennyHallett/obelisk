defmodule Obelisk.Git do

  def clone(url) do
    parse_url(url)
    |> _clone
  end

  defp _clone({url, dir}) do
    System.cmd "git", ["clone", url, "./themes/#{dir}"]
  end

  def parse_url(url) do
    url
    |> String.split("/")
    |> Enum.reverse
    |> hd
    |> String.split(".")
    |> Enum.reverse
    |> tl
    |> Enum.reverse
    |> Enum.join(".")
    |> _parse_url(url)
  end

  defp _parse_url(dir, url), do: {url, dir}

end
