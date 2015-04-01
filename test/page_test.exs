defmodule PageTest do
  use ExUnit.Case, async: false

  setup do
    TestHelper.cleanup
    on_exit fn -> TestHelper.cleanup end
  end

  test "can list pages" do
    Obelisk.Tasks.Init.run []
    File.touch "./pages/about-me.markdown"
    pages = Obelisk.Page.list
    assert 1 == Enum.count(pages)
    [h|_] = pages
    assert h == "about-me.markdown"
  end

end
