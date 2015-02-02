defmodule ThemeTest do
  use ExUnit.Case

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

  test "" do

  end

end
