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

  defp ensure_local(true, _theme), do: true
  defp ensure_local(false, theme), do: raise(Obelisk.Errors.ThemeNotFound, {:local, theme})

end
