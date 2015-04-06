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

  test "next page on last page" do
    assert "" == Blog.next_page(1, true)
  end

  test "next page on not last page" do
    assert "<a href=\"index3.html\">Next Page</a>" == Blog.next_page(2, false)
  end

  test "prev page on first" do
    assert "" == Blog.previous_page(1)
  end

  test "prev page on second" do
    assert "<a href=\"index.html\">Previous Page</a>" == Blog.previous_page(2)
  end

  test "prev page on another" do
    assert "<a href=\"index9.html\">Previous Page</a>" == Blog.previous_page(10)
  end

  test "next page not on last page with single page config" do
    Obelisk.Config.force %{ blog_index: "blog.html" }

    assert "<a href=\"blog3.html\">Next Page</a>" == Blog.next_page(2, false)
  end

  test "next page not on last page with path config" do
    Obelisk.Config.force %{ blog_index: "blog/index.html" }

    assert "<a href=\"blog/index3.html\">Next Page</a>" == Blog.next_page(2, false)
  end

  test "previous page on second with single page config" do
    Obelisk.Config.force %{ blog_index: "blog.html" }

    assert "<a href=\"blog.html\">Previous Page</a>" == Blog.previous_page(2)
  end

  test "previous page on second with path config" do
    Obelisk.Config.force %{ blog_index: "blog/index.html" }

    assert "<a href=\"blog/index.html\">Previous Page</a>" == Blog.previous_page(2)
  end

  test "previous page on fourth with single page config" do
    Obelisk.Config.force %{ blog_index: "blog.html" }

    assert "<a href=\"blog3.html\">Previous Page</a>" == Blog.previous_page(4)
  end

  test "previous page on fourth with path config" do
    Obelisk.Config.force %{ blog_index: "blog/index.html" }

    assert "<a href=\"blog/index3.html\">Previous Page</a>" == Blog.previous_page(4)
  end


end
