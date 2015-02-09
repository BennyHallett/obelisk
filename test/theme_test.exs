defmodule ThemeTest do
  use ExUnit.Case, async: false
  import Mock

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "Local theme raises error when theme doesnt exist" do
    Obelisk.Config.force %{ theme: "missing" }
    assert_raise Obelisk.Errors.ThemeNotFound, fn ->
      Obelisk.Theme.ensure
    end
  end

  test "Default theme works" do
    Obelisk.Tasks.Init.run []
    "default" = Obelisk.Config.config |> Dict.get(:theme)
    assert Obelisk.Theme.ensure
  end

  test "github theme doesn't get cloned if exists" do
    # Works off repo name so we can use 'default'
    Obelisk.Tasks.Init.run []
    repo = "https://github.com/bennyhallett/default.git"
    Obelisk.Config.force %{ theme: "bennyhallett/default" }

    with_mock Obelisk.Git, [clone: fn(_url) -> "cloned" end] do
      assert Obelisk.Theme.ensure
      assert not called Obelisk.Git.clone(repo)
    end
  end

  test "clone github repo" do
    repo = "https://github.com/bennyhallett/theme.git"
    Obelisk.Config.force %{ theme: "bennyhallett/theme" }

    with_mock Obelisk.Git, [clone: fn(_url) -> "cloned" end] do
      Obelisk.Theme.ensure
      assert called Obelisk.Git.clone(repo)
    end

  end

  test "url theme doesnt get cloned if it exists" do
    # Works off repo name so we can use 'default'
    Obelisk.Tasks.Init.run []
    repo = "https://github.com/bennyhallett/default.git"
    Obelisk.Config.force %{ theme: repo }

    with_mock Obelisk.Git, [clone: fn(_url) -> "cloned" end] do
      assert Obelisk.Theme.ensure
      assert not called Obelisk.Git.clone(repo)
    end

  end

  test "clone http url" do
    repo = "https://github.com/bennyhallett/theme.git"
    Obelisk.Config.force %{ theme: repo }

      with_mock Obelisk.Git, [clone: fn(_url) -> "cloned" end] do
        Obelisk.Theme.ensure
        assert called Obelisk.Git.clone(repo)
      end
  end

end
