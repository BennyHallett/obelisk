defmodule Obelisk.Theme do

  @moduledoc """
  Functions to manage themes.
  """

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

  defp ensure_local(true, _theme), do: true
  defp ensure_local(false, theme), do: raise(Obelisk.Errors.ThemeNotFound, {:local, theme})

  defp ensure_github(true, _user, _repo), do: true
  defp ensure_github(false, user, repo) do
    "https://github.com/#{user}/#{repo}.git"
    |> Obelisk.Git.clone
  end

end
