defmodule BuildTaskTest do
  use ExUnit.Case, async: false

  setup do
    TestHelper.cleanup
    on_exit fn -> TestHelper.cleanup end
  end

  test "Build task compiles posts into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Enum.each(10..15, fn day -> create_post day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{filename(day)}.html") end)
  end

  test "Build task compiled pages into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Enum.each(10..15, fn day -> create_page day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{pagename(day)}.html") end)
  end

  test "Index page doesnt include next link on last page" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Obelisk.Tasks.Build.run([])

    assert !String.contains? File.read!("./build/index.html"), "<a href=\"index2.html\">Next Page</a>"
  end

  test "Build task copies assets into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Obelisk.Tasks.Build.run([])

    assert File.dir? "./build/assets"
    assert File.dir? "./build/assets/css"
    assert File.dir? "./build/assets/js"
    assert File.dir? "./build/assets/img"
  end

  test "Config limits items per index page" do
    Obelisk.Tasks.Init.run []
    Obelisk.Config.reload
    1..10 |> Enum.each(&(create_post &1))
    File.write("site.yml", """
    ---
    name: My Blog
    description: My Blog about things
    url: http://my.blog.com
    posts_per_page: 5
    theme: default
    """)
    Obelisk.Config.reload
    Obelisk.Tasks.Build.run []

    assert File.exists? "./build/index.html"
    assert File.exists? "./build/index2.html"
    assert File.exists? "./build/index3.html"

    p1 = File.read!("./build/index.html") |> String.split("\.html")
    p2 = File.read!("./build/index2.html") |> String.split("\.html")
    p3 = File.read!("./build/index3.html") |> String.split("\.html")

    assert length(p1) == 7 # one extra for next page
    assert length(p2) == 8 # two extra for both next and prev
    assert length(p3) == 3 # one extra for prev page
  end

  defp filename(day) do
    "2014-01-#{day}-post-with-day-#{day}"
  end

  defp pagename(day) do
    "page-#{day}"
  end

  defp create_post(day) do
    File.write("./posts/#{filename(day)}.markdown", content)
  end

  defp create_page(day) do
    File.write("./pages/#{pagename(day)}.markdown", content)
  end

  defp content do
    """
    ---
    title: This is the heading
    description: This is the desc
    created: 2015-01-01
    ---

    * And
    * A
    * List
    * Of
    * Things

    `and some inline code` for good measure
    """
  end

end
