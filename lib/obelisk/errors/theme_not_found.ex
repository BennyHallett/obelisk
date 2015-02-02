defmodule Obelisk.Errors.ThemeNotFound do
  defexception [:message]

  def exception({:local, theme}) do
    msg = "Local theme '#{theme}' doesn't exist at './themes/#{theme}/'"
    %Obelisk.Errors.ThemeNotFound{message: msg}
  end
end
