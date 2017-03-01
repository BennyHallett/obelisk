defmodule BuildTaskTest do
  use ExUnit.Case, async: false

  setup do
    TestHelper.cleanup
    on_exit fn -> TestHelper.cleanup end
  end

  test "Build task compiles posts into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Enum.each(10..15, fn day -> create_valid_post day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{filename(day)}.html") end)
  end

  test "Build task does not compile invalid posts into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    md_filenames =
      [ ".2014-01-01-hidden-post.markdown",
        "2014-01-1-post-with-unpadded-day.markdown",
        "2014-1-01-post-with-unpadded-month.markdown",
        "2014-01-01-post-with-unexpected.extension"
      ]
    Enum.each(md_filenames, fn md_filename -> create_post md_filename end)
    Obelisk.Tasks.Build.run([])

    Enum.each(md_filenames, fn md_filename ->
      [filename | _] = String.split md_filename, ".markdown"

      refute File.exists?("./build/#{filename}.html")
    end)
  end

  test "Build task compiled pages into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    Enum.each(10..15, fn day -> create_valid_page day end)
    Obelisk.Tasks.Build.run([])

    Enum.each(10..15, fn day -> assert File.exists?("./build/#{pagename(day)}.html") end)
  end

  test "Build task does not compile invalid pages into the build dir" do
    Obelisk.Tasks.Init.run([])
    Obelisk.Config.reload
    md_filenames =
      [ ".2014-01-01-hidden-page.markdown",
        "2014-01-01-page-with-unexpected.extension"
      ]
    Enum.each(md_filenames, fn md_filename -> create_post md_filename end)
    Obelisk.Tasks.Build.run([])

    Enum.each(md_filenames, fn md_filename ->
      [filename | _] = String.split md_filename, ".markdown"

      refute File.exists?("./build/#{filename}.html")
    end)
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
    1..10 |> Enum.each(&create_valid_post(&1))
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

  test "build blog part to different page" do
    Obelisk.Tasks.Init.run([])
    1..10 |> Enum.each(&create_valid_post(&1))
    File.write("site.yml", """
    ---
    name: My Blog
    description: My Blog about things
    url: http://my.blog.com
    posts_per_page: 5
    theme: default
    blog_index: "blog.html"
    """)
    Obelisk.Config.reload
    Obelisk.Tasks.Build.run([])

    assert File.exists? "./build/blog.html"
    assert File.exists? "./build/blog2.html"
  end

  test "build blog part to different directory" do
    Obelisk.Tasks.Init.run([])
    1..10 |> Enum.each(&create_valid_post(&1))
    File.write("site.yml", """
    ---
    name: My Blog
    description: My Blog about things
    url: http://my.blog.com
    posts_per_page: 5
    theme: default
    blog_index: "blog/index.html"
    """)
    Obelisk.Config.reload
    Obelisk.Tasks.Build.run([])

    assert File.exists? "./build/blog/index.html"
    assert File.exists? "./build/blog/index2.html"

  end

  defp filename(day) do
    padded_day = String.rjust to_string(day), 2, ?0

    "2014-01-#{padded_day}-post-with-day-#{padded_day}"
  end

  defp pagename(day) do
    "page-#{day}"
  end

  defp create_post(filename) do
    File.write("./posts/#{filename}", content)
  end

  defp create_valid_post(day) do
    create_post "#{filename(day)}.markdown"
  end

  defp create_page(filename) do
    File.write("./pages/#{filename}", content)
  end

  defp create_valid_page(day) do
    create_page "#{pagename(day)}.markdown"
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
