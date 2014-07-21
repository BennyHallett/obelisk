defmodule PostTaskTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Create new post" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Tasks.Post.run([ "An awesome post" ])

    assert File.exists? "./posts/#{TestHelper.datepart}-an-awesome-post.markdown"
    content = File.read! "./posts/#{TestHelper.datepart}-an-awesome-post.markdown"
    assert String.contains? content, "title: An awesome post"
  end

  test "Command should fail if no args are passed" do
    Obelisk.Tasks.Init.run([])
    assert_raise ArgumentError, "Cannot create a new post without the post name", fn ->
      Obelisk.Tasks.Post.run([])
    end
  end

end
