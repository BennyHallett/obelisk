defmodule Obelisk.Date do

  def today do
    Chronos.today
    |> Chronos.Formatter.strftime("%Y-%0m-%0d")
  end

  def now do
    Chronos.now
    |> Chronos.Formatter.strftime("%Y-%0m-%0d %H:%M:%S")
  end

end
