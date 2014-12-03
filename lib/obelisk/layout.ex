defmodule Obelisk.Layout do
  alias Obelisk.Config

  def path do
    "./themes/#{Config.config.theme}/layout/layout.eex"
  end

  def layout do
    File.read!(path)
  end

  def post do
    File.read!("./themes/#{Config.config.theme}/layout/post.eex")
  end

  def page do
    File.read!("./themes/#{Config.config.theme}/layout/page.eex")
  end

  def index do
    File.read!("./themes/#{Config.config.theme}/layout/index.eex")
  end

end
