defmodule Obelisk.Theme do

  @moduledoc """
  Functions to manage themes.
  """

  @doc """
  Get the currently selected theme as defined in
  `site.yml`

  This will be the repo part only, which will match the
  directory that the theme will be localed in under `/themes`.

  For example, having `theme: http://git.com/user/theme` in
  `site.yml` will result in `theme` from this function.
  """

  def current do
    Obelisk.Config.config
    |> Dict.get(:theme)
    |> String.split("/")
    |> _current
  end

  defp _current([local]), do: local
  defp _current([_user, repo]), do: repo
  defp _current(url), do: url |> Enum.reverse |> hd |> String.replace("\.git", "")

  @doc """
  Ensures that the nominated theme is available.
  """

  def ensure do
    Obelisk.Config.config
    |> Dict.get(:theme)
    |> String.split("/")
    |> _ensure
  end

  defp _ensure([local]), do: ensure_local(File.dir?("themes/#{local}"), local)
  defp _ensure([user, repo]), do: ensure_github(File.dir?("themes/#{repo}"), user, repo)
  defp _ensure(url), do: ensure_url(url)

  defp ensure_local(true, _theme), do: true
  defp ensure_local(false, theme), do: raise(Obelisk.Errors.ThemeNotFound, {:local, theme})

  defp ensure_github(true, _user, _repo), do: true
  defp ensure_github(false, user, repo) do
    "https://github.com/#{user}/#{repo}.git"
    |> Obelisk.Git.clone
  end

  defp ensure_url(url) do
    repo = url
    |> Enum.reverse
    |> hd
    |> String.replace("\.git", "")

    _ensure_url(File.dir?("themes/#{repo}"), Enum.join(url, "/"))
  end

  def _ensure_url(true, _url), do: true
  def _ensure_url(false, url), do: url |> Obelisk.Git.clone

end
