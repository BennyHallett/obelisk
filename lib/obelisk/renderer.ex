defmodule Obelisk.Renderer do

  def render(content), do: Earmark.to_html(content)

  def render({template,  :eex}, params), do: EEx.eval_string(template, assigns: params)
  def render({template, :haml}, params), do: Calliope.render(template, params)
  def render(content, format), do: render(content, [], format)

  def render(content, params,  :eex), do: EEx.eval_string(content, assigns: params)
  def render(content, params, :haml), do: Calliope.render(content, params)

end
