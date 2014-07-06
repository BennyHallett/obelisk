defmodule AssetsTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "List out css" do
    Obelisk.Tasks.Init.run([])
    File.touch "./assets/css/one.css"
    File.touch "./assets/css/two.css"
    File.touch "./assets/css/three.css"
    Obelisk.Tasks.Build.run([])

    files = Obelisk.Assets.css_files
    assert 4 == Enum.count(files)
    IO.puts files
    assert Enum.find(files, &(&1 == "assets/css/base.css")) != nil
    assert Enum.find(files, &(&1 == "assets/css/one.css")) != nil
    assert Enum.find(files, &(&1 == "assets/css/two.css")) != nil
    assert Enum.find(files, &(&1 == "assets/css/three.css")) != nil
  end

  test "Get html to reference css" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Build.run([])

    css_links = Obelisk.Assets.css
    assert css_links == "<link rel=\"stylesheet\" href=\"assets/css/base.css\" />"
  end

end
