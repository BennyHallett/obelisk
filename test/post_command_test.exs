defmodule PostTaskTest do
  use ExUnit.Case, async: true
  import Mock

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

  test "New post has datetime in front matter" do
    with_mock Chronos, [now: fn -> {{2015, 01, 01}, {10, 10, 10}} end, today: fn -> {2015, 01, 01} end] do
      Obelisk.Tasks.Init.run([])
      Obelisk.Tasks.Post.run(["Dates should be in frontmatter"])

      assert File.exists? "./posts/2015-01-01-dates-should-be-in-frontmatter.markdown"
      content = File.read! "./posts/2015-01-01-dates-should-be-in-frontmatter.markdown"
      assert String.contains? content, "created: 2015-01-01 10:10:10"
    end
  end

  test "Command should fail if no args are passed" do
    Obelisk.Tasks.Init.run([])
    assert_raise ArgumentError, "Cannot create a new post without the post name", fn ->
      Obelisk.Tasks.Post.run([])
    end
  end

end
