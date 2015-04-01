defmodule LayoutTest do
  use ExUnit.Case, async: false

  setup do
    Obelisk.Tasks.Init.run []
    Obelisk.Config.force %{ theme: "default", posts_per_page: 5 }
    on_exit fn -> TestHelper.cleanup end
  end

  test "load eex layout" do
    "./themes/default/layout/layout.eex"
    |> File.write("layout")

    assert { "layout", :eex } == Obelisk.Layout.layout
  end

  test "load html.eex layout" do
    "./themes/default/layout/layout.eex"
    |> File.rm

    "./themes/default/layout/layout.html.eex"
    |> File.write("layout")

    assert { "layout", :eex } == Obelisk.Layout.layout
  end

  test "load eex post" do
    "./themes/default/layout/post.eex"
    |> File.write("post")

    assert { "post", :eex } == Obelisk.Layout.post
  end

  test "load html.eex post" do
    "./themes/default/layout/post.eex"
    |> File.rm

    "./themes/default/layout/post.html.eex"
    |> File.write("post")

    assert { "post", :eex } == Obelisk.Layout.post
  end

  test "load eex page" do
    "./themes/default/layout/page.eex"
    |> File.write("page")

    assert { "page", :eex } == Obelisk.Layout.page
  end

  test "load html.eex page" do
    "./themes/default/layout/page.eex"
    |> File.rm

    "./themes/default/layout/page.html.eex"
    |> File.write("page")

    assert { "page", :eex } == Obelisk.Layout.page
  end

  test "load eex index" do
    "./themes/default/layout/index.eex"
    |> File.write("index")

    assert { "index", :eex } == Obelisk.Layout.index
  end

  test "load html.eex index" do
    "./themes/default/layout/index.eex"
    |> File.rm

    "./themes/default/layout/index.html.eex"
    |> File.write("index")

    assert { "index", :eex } == Obelisk.Layout.index
  end

  test "load haml layout" do
    "./themes/default/layout/layout.eex"
    |> File.rm

    "./themes/default/layout/layout.haml"
    |> File.write("layout")

    assert { "layout", :haml } == Obelisk.Layout.layout
  end

  test "load html.haml layout" do
    "./themes/default/layout/layout.eex"
    |> File.rm

    "./themes/default/layout/layout.html.haml"
    |> File.write("layout")

    assert { "layout", :haml } == Obelisk.Layout.layout
  end

  test "load haml post" do
    "./themes/default/layout/post.eex"
    |> File.rm

    "./themes/default/layout/post.haml"
    |> File.write("post")

    assert { "post", :haml } == Obelisk.Layout.post
  end

  test "load html.haml post" do
    "./themes/default/layout/post.eex"
    |> File.rm

    "./themes/default/layout/post.html.haml"
    |> File.write("post")

    assert { "post", :haml } == Obelisk.Layout.post
  end

  test "load haml page" do
    "./themes/default/layout/page.eex"
    |> File.rm

    "./themes/default/layout/page.haml"
    |> File.write("page")

    assert { "page", :haml } == Obelisk.Layout.page
  end

  test "load html.haml page" do
    "./themes/default/layout/page.eex"
    |> File.rm

    "./themes/default/layout/page.html.haml"
    |> File.write("page")

    assert { "page", :haml } == Obelisk.Layout.page
  end

  test "load haml index" do
    "./themes/default/layout/index.eex"
    |> File.rm

    "./themes/default/layout/index.haml"
    |> File.write("index")

    assert { "index", :haml } == Obelisk.Layout.index
  end

  test "load html.haml index" do
    "./themes/default/layout/index.eex"
    |> File.rm

    "./themes/default/layout/index.html.haml"
    |> File.write("index")

    assert { "index", :haml } == Obelisk.Layout.index
  end


end
