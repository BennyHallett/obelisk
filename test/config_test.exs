defmodule ConfigTest do
  use ExUnit.Case

  setup do
    on_exit fn -> TestHelper.cleanup end
  end

  test "loading config fails if config does not exist" do
    assert_raise RuntimeError, "Couldn't find configuration file: site.yml", fn ->
      Obelisk.Config.config
    end
  end

  test "loading config succeeds" do
    Obelisk.Tasks.Init.run([])
    config = Obelisk.Config.config
    assert "A brand new static site" == config.name
  end

end
