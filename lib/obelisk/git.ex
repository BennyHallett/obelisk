defmodule Obelisk.Git do

  def clone(url) do
    parse_url(url) |> _clone
  end

  defp _clone({url, dir}) do
    Obelisk.Git.System.cmd("git", ["clone", url, "./themes/#{dir}"])
  end

  def parse_url(url) do
    %URI{
      authority: _,
      fragment: _,
      host: _,
      path: path,
      port: _,
      query: _,
      scheme: _,
      userinfo: _
    } = URI.parse(url)

    {url, Path.basename(path, ".git")}
  end

  defmodule System do
    @moduledoc """
    Wrap `System` so we can test the `Obelisk.Git.clone call`
    and mock this one
    """

    def cmd(cmd, args) do
      System.cmd cmd, args
    end
  end
end
