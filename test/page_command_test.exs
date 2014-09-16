defmodule PageTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Create new post" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Page.run([ "An awesome page" ])

    assert File.exists? "./pages/an-awesome-page.markdown"
    content = File.read! "./pages/an-awesome-page.markdown"
    assert String.contains? content, "title: An awesome page"
  end

  test "Command should fail if no args are passed" do
    Obelisk.Tasks.Init.run([])
    assert_raise ArgumentError, "Cannot create a new page without the post name", fn ->
      Obelisk.Tasks.Page.run([])
    end
  end

end
