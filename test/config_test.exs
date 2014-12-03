defmodule ConfigTest do
  use ExUnit.Case

  setup do
    Application.start :obelisk
    on_exit fn -> TestHelper.cleanup end
  end

  test "config is default if it doesn't exist not exist" do
    default = Obelisk.YamlToDict.convert(%{}, hd(:yamerl_constr.string(Obelisk.Templates.config)))
    assert default == Obelisk.Config.config
  end

  test "loading config succeeds" do
    Obelisk.Tasks.Init.run([])
    config = Obelisk.Config.config
    assert "A brand new static site" == config.name
  end

end
