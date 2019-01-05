defmodule Obelisk.Renderer do

  def render(content, format), do: render(content, [], format)

  def render(content, params, :eex), do: EEx.eval_string(content, assigns: ensure_global(params))
  def render(content, params, :haml), do: Calliope.render(content, ensure_global(params))

  def ensure_global(params) do
    params
    |> Keyword.merge([site: Obelisk.Config.config])
  end
end
