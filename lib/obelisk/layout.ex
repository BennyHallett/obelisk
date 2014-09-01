defmodule Obelisk.Layout do

  def path do
    "./layout/layout.eex"
  end

  def layout do
    File.read!(path)
  end

  def post do
    File.read!("./layout/post.eex")
  end

  def page do
    File.read!("./layout/page.eex")
  end

  def index do
    File.read!("./layout/index.eex")
  end

end
