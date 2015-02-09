defmodule Obelisk.Layout do
  alias Obelisk.Theme

  def path do
    "./themes/#{Theme.current}/layout/layout.eex"
  end

  def layout do
    File.read!(path)
  end

  def post do
    File.read!("./themes/#{Theme.current}/layout/post.eex")
  end

  def page do
    File.read!("./themes/#{Theme.current}/layout/page.eex")
  end

  def index do
    File.read!("./themes/#{Theme.current}/layout/index.eex")
  end

end
