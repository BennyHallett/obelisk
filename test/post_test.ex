defmodule PostTest do
  use ExUnit.Case

  setup do
  end

  test "Can properly parse md filename to post name" do
    filename = "2014-02-03-this-is-a-test.markdown"
    processed = Obelisk.Post.title(filename)
    assert processed == "This is a test"
  end

end
