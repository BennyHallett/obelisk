defmodule LayoutTest do
  use ExUnit.Case

  setup do
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

  test "layout path" do
    assert "./themes/default/layout/layout.eex" == Obelisk.Layout.path
  end

  test "test get post layout" do
    Obelisk.Tasks.Init.run []
    assert String.contains?(Obelisk.Layout.post, "<div id=\"post\">")
  end

  test "get page layout" do
    Obelisk.Tasks.Init.run []
    assert String.contains?(Obelisk.Layout.page, "<div id=\"page\">")
  end

  test "test get layout" do
    Obelisk.Tasks.Init.run []
    assert String.contains?(Obelisk.Layout.layout, "<!DOCTYPE html>")
  end

end
