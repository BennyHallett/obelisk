defmodule InitTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn ->
      File.rm_rf "./assets"
      File.rmdir "./posts"
      File.rmdir "./drafts"
      File.rmdir "./pages"
      File.rmdir "./layout"
      File.rm "./config.yml"
    end
  end

  test "Init task creates assets directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./assets"
    assert File.dir? "./assets/css"
    assert File.dir? "./assets/js"
    assert File.dir? "./assets/img"
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
  end

  test "Init task creates initial config file" do
    Obelisk.Tasks.Init.run([])

    assert File.exists? "./config.yml"
  end
end
