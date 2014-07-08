defmodule InitTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Init task creates assets directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./assets"
    assert File.dir? "./assets/css"
    assert File.dir? "./assets/js"
    assert File.dir? "./assets/img"
    assert File.exists? "./assets/css/base.css"
  end

  test "Init task creates content directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./posts"
    assert File.dir? "./drafts"
    assert File.dir? "./pages"
  end

  test "Init task creates layout directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./layout"
    assert File.exists? "./layout/post.eex"
  end

  test "Init task creates initial config file" do
    Obelisk.Tasks.Init.run([])

    assert File.exists? "./site.yml"
  end

  test "Init task creates first post" do
    Obelisk.Tasks.Init.run([])

    assert File.exists? "./posts/2014-01-01-welcome-to-obelisk.markdown"
  end
end
