defmodule Obelisk.Renderer do

  def render(content, format), do: render(content, [], format)

  def render(content, params, :eex), do: EEx.eval_string(content, assigns: params)
  def render(content, params, :haml), do: Calliope.render(content, params)

end
