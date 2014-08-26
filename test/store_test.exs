defmodule StoreTest do
  use ExUnit.Case, async: true

  test "Initial config is empty" do
    { :ok, store } = Obelisk.Store.start_link

    cfg = Obelisk.Store.get_config(store)
    assert length(Dict.keys(cfg)) ==  0
  end

  test "Initial posts are empty" do
    { :ok, store } = Obelisk.Store.start_link

    posts = Obelisk.Store.get_posts(store)
    assert length(Dict.keys(posts)) == 0
  end

  test "Initial pages are empty" do
    { :ok, store } = Obelisk.Store.start_link

    pages = Obelisk.Store.get_pages store
    assert length(Dict.keys pages) == 0
  end

  test "Layouts are loaded initially" do
    { :ok, store } = Obelisk.Store.start_link

    layouts = Obelisk.Store.get_layouts store
    assert Obelisk.Layout.layout == layouts.layout
    assert Obelisk.Layout.post == layouts.post
    assert Obelisk.Layout.page == layouts.page

  end

  test "Set configuration" do
    { :ok, store } = Obelisk.Store.start_link
    Obelisk.Store.set_config store, %{ a: "A", b: "B" }

    stored_cfg = Obelisk.Store.get_config store
    assert stored_cfg.a == "A"
    assert stored_cfg.b == "B"
  end

  test "Add posts" do
    { :ok, store } = Obelisk.Store.start_link
    posts = [ "A", "B", "C" ]
    Obelisk.Store.add_posts store, posts

    stored_posts = Obelisk.Store.get_posts store
    assert length(stored_posts) == 3
    assert Enum.join(stored_posts) == "ABC"
  end

  test "Add pages" do
    { :ok, store } = Obelisk.Store.start_link
    pages = [ "A", "B", "C" ]
    Obelisk.Store.add_pages store, pages

    stored_pages = Obelisk.Store.get_pages store
    assert length(stored_pages) == 3
    assert Enum.join(stored_pages) == "ABC"
  end

end
