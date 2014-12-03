defmodule InitTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Init task creates assets directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./themes"
    assert File.dir? "./themes/default"
    assert File.dir? "./themes/default/assets"
    assert File.dir? "./themes/default/assets/css"
    assert File.dir? "./themes/default/assets/js"
    assert File.dir? "./themes/default/assets/img"
    assert File.exists? "./themes/default/assets/css/base.css"

    assert File.dir? "./themes/default/layout"
    assert File.exists? "./themes/default/layout/layout.eex"
    assert File.exists? "./themes/default/layout/post.eex"
    assert File.exists? "./themes/default/layout/page.eex"
  end

  test "Init task creates content directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./posts"
    assert File.dir? "./drafts"
    assert File.dir? "./pages"
  end

  test "Init task creates initial config file" do
    Obelisk.Tasks.Init.run([])

    assert File.exists? "./site.yml"
  end

  test "Init task creates first post" do
    Obelisk.Tasks.Init.run([])

    assert File.exists? "./posts/#{TestHelper.datepart}-welcome-to-obelisk.markdown"
  end
end
