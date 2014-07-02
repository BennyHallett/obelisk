defmodule InitTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn ->
      File.rm_rf "./assets"
    end
  end

  test "Init task creates assets directory structure" do
    Obelisk.Tasks.Init.run([])

    assert File.dir? "./assets"
    assert File.dir? "./assets/css"
    assert File.dir? "./assets/js"
    assert File.dir? "./assets/img"
  end
end
