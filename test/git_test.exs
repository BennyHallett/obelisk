defmodule GitTest do
  use ExUnit.Case
  import Mock

  setup do
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

  test "Parse git url properly" do
    url = "http://github.com/test/repo.git"
    assert { url, "repo" } == Obelisk.Git.parse_url(url)
  end

  test "Clone repo" do
    with_mock System, [cmd: fn(_cmd, _args) -> "cloned" end] do
      Obelisk.Git.clone("http://example.com/user/repo.git")
      assert called System.cmd("git", ["clone", "http://example.com/user/repo.git", "./themes/repo"])
    end
  end

end
