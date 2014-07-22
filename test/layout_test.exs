defmodule LayoutTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "layout path" do
    assert "./layout/layout.eex" == Obelisk.Layout.path
  end

  test "test get post layout" do
    assert String.contains?(Obelisk.Layout.post, "<div id=\"post\">")
  end

end
