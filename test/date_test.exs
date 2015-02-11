defmodule DateTest do
  use ExUnit.Case
  import Mock

  setup do
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

  test "Get formatted date" do
    with_mock Chronos, [today: fn -> {2015, 01, 01} end] do
      assert "2015-01-01" == Obelisk.Date.today
    end
  end

  test "Get formatted datetime" do
    with_mock Chronos, [now: fn -> {{2015, 01, 01}, {10, 10, 10}} end] do
      assert "2015-01-01 10:10:10" == Obelisk.Date.now
    end
  end

end
