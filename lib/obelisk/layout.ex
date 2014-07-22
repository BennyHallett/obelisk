defmodule Obelisk.Layout do

  def path do
    "./layout/layout.eex"
  end

  def post do
    File.read!("./layout/post.eex")
  end

end
