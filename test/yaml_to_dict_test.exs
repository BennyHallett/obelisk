defmodule YamlToDictTest do
  use ExUnit.Case, async: false

  test "Can convert yaml to dict" do
    assert %{a: "a", b: "b"} == Obelisk.YamlToDict.convert(%{}, [{'a', 'a'}, {'b', 'b'}])
  end

end
