defmodule InitTaskTest do
  use ExUnit.Case, async: false

  setup do
    Obelisk.Site.test_setup(System.tmp_dir)

    on_exit fn -> TestHelper.cleanup end
  end

  test "Init task creates assets directory structure" do
    dirs = ~w(./themes ./themes/default ./themes/default/assets ./themes/default/assets/css
        ./themes/default/assets/js ./themes/default/assets/img ./themes/default/assets/css/base.css
        ./themes/default/layout)
    Enum.each(dirs, fn(dir) -> File.dir? dir |> assert end)

    files = ~w(./themes/default/layout/layout.eex ./themes/default/layout/post.eex
    ./themes/default/layout/page.eex)
    Enum.each(files, fn(file) -> File.exists?(file) |> assert end)
  end

  test "Init task creates content directory structure" do
    assert File.dir? "./posts"
    assert File.dir? "./drafts"
    assert File.dir? "./pages"
  end

  test "Init task creates initial config file" do
    assert File.exists? "./site.yml"
  end

  test "Init task creates first post" do
    assert File.exists? "./posts/#{TestHelper.datepart}-welcome-to-obelisk.markdown"
  end

  test "appends the build dir to the .gitignore" do
    assert File.exists?(".gitignore")
    { :ok, file } = File.read(".gitignore")

    assert String.match?(file, ~r/build\n\z/)
  end
end
