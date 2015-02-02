defmodule GitTest do
  use ExUnit.Case

  setup do
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

  test "Parse git url properly" do
    url = "http://github.com/test/repo.git"
    assert { url, "repo" } == Obelisk.Git.parse_url(url)
  end

end
