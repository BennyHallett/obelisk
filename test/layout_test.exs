defmodule LayoutTest do
  use ExUnit.Case

  setup do
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

end
