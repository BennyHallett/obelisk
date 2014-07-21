defmodule DraftTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Create new draft" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Draft.run([ "Not quite ready yet" ])

    assert File.exists? "./drafts/#{TestHelper.datepart}-not-quite-ready-yet.markdown"
    content = File.read! "./drafts/#{TestHelper.datepart}-not-quite-ready-yet.markdown"
    assert String.contains? content, "title: Not quite ready yet"
  end

  test "Command should fail if no args are passed" do
    Obelisk.Tasks.Init.run([])
    assert_raise ArgumentError, "Cannot create a new draft without the post name", fn ->
      Obelisk.Tasks.Draft.run([])
    end
  end

end
