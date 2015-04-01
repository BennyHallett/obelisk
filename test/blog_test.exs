defmodule BlogTest do
  use ExUnit.Case, async: false
  alias Obelisk.Blog

  setup do
    Obelisk.Config.reload
    on_exit fn -> Obelisk.Config.reload end
  end

  test "html filename with no config is index.html" do
    assert "./build/index.html" == Blog.html_filename(1)
  end

  test "html filename page 10 with no config is index10.html" do
    assert "./build/index10.html" == Blog.html_filename(10)
  end

  test "html filename with single page config is blog.html" do
    Obelisk.Config.force %{ blog_index: "blog.html" }
    assert "./build/blog.html" == Blog.html_filename(1)
  end

  test "html filename with single page 10 config is blog10.html" do
    Obelisk.Config.force %{ blog_index: "blog.html" }
    assert "./build/blog10.html" == Blog.html_filename(10)
  end

  test "html filename with path config is blog/index.html" do
    Obelisk.Config.force %{ blog_index: "blog/index.html" }
    assert "./build/blog/index.html" == Blog.html_filename(1)
  end

  test "html filename with path 10 config is blog/index10.html" do
    Obelisk.Config.force %{ blog_index: "blog/index.html" }
    assert "./build/blog/index10.html" == Blog.html_filename(10)
  end

end
